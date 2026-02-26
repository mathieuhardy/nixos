#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
    cat << EOF
Usage: $(basename "${0}") [OPTIONS]

Check if you local branches are merged into a remote branch on GitLab.

OPTIONS:
    -r, --remote BRANCH    Reference remote branch (default: origin/main)
    -e, --exclude PATTERN  Exclude branches that match the pattern
    -h, --help             Display this help

EXAMPLES:
    $(basename "$0")
    $(basename "$0") -r origin/develop
    $(basename "$0") -r origin/main -e "feature/*"
EOF
}

# Default parameters
REMOTE_BRANCH="origin/main"
EXCLUDE_PATTERN=""

# Parse CLI arguments
while [[ ${#} -gt 0 ]]
do
    case ${1} in
        -r|--remote)
            REMOTE_BRANCH="${2}"
            shift 2
            ;;

        -e|--exclude)
            EXCLUDE_PATTERN="${2}"
            shift 2
            ;;

        -h|--help)
            show_help
            exit 0
            ;;

        *)
            echo "Unknown option: ${1}"
            show_help
            exit 1
            ;;
    esac
done

# Check if we're in a Git repository
if ! git rev-parse --git-dir > /dev/null 2>&1
then
    echo -e "${RED}Error: not in a Git repository${NC}"
    exit 1
fi

# Fetch the last commits from remote
echo -e "${BLUE}Fetching remote data${NC}"
git fetch --all --quiet

# Check if the branch exists
if ! git rev-parse --verify "${REMOTE_BRANCH}" > /dev/null 2>&1
then
    echo -e "${RED}Error: the branch ${REMOTE_BRANCH} doesn't exist${NC}"
    exit 1
fi

echo -e "${BLUE}Checking local branches against ${YELLOW}${REMOTE_BRANCH}${NC}\n"

# Counts
MERGED=0
NOT_MERGED=0

# Get all local branches
while read -r branch
do
    # Apply exclusion
    if [[ -n "${EXCLUDE_PATTERN}" ]] && [[ "${branch}" == ${EXCLUDE_PATTERN} ]]
    then
        continue
    fi

    # Filter remote branch
    if [[ "origin/${branch}" = "${REMOTE_BRANCH}" ]]
    then
        continue
    fi

    # Check if the branch is merged
    if git merge-base --is-ancestor "${branch}" "${REMOTE_BRANCH}" 2>/dev/null
    then
        echo -e " ┃ ${GREEN}✓${NC} ${branch} ${GREEN}(merged)${NC}"
        ((MERGED++))
    else
        # Compute the diff ahead/behind
        AHEAD=$(git rev-list --count "${REMOTE_BRANCH}..${branch}" 2>/dev/null || echo "0")
        BEHIND=$(git rev-list --count "${branch}..${REMOTE_BRANCH}" 2>/dev/null || echo "0")

        echo -e " ┃ ${RED}✗${NC} ${branch} ${RED}(not merged)${NC} - ${YELLOW}+${AHEAD}${NC}/${YELLOW}-${BEHIND}${NC} commits"
        ((NOT_MERGED++))
    fi
done < <(git for-each-ref --format='%(refname:short)' refs/heads/)

# Summary
echo -e ""
echo -e " ┃ ${BLUE}Summary:${NC}"
echo -e " ┃ ${GREEN}Branches merged:     ${MERGED}${NC}"
echo -e " ┃ ${RED}Branches not merged: ${NOT_MERGED}${NC}"
