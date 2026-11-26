#!/usr/bin/env bash
# Vérifie les mises à jour disponibles pour les dérivations NixOS qui
# téléchargent des binaires/archives depuis GitHub.
#
# Usage: ./check-github-updates.sh [répertoire-nixos]
# Env:   GITHUB_TOKEN  token GitHub pour passer de 60 à 5000 req/h

set -euo pipefail

NIXOS_DIR="${1:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

# ── Couleurs & icônes ─────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

up_to_date=0
outdated=0
errors=0

# ── API GitHub ────────────────────────────────────────────────────────────────
github_api() {
    local url="$1"
    local args=(-s -f --max-time 10
        -H "Accept: application/vnd.github+json"
        -H "X-GitHub-Api-Version: 2022-11-28"
        -H "User-Agent: nixos-update-checker")
    [[ -n "$GITHUB_TOKEN" ]] && args+=(-H "Authorization: Bearer $GITHUB_TOKEN")
    curl "${args[@]}" "$url"
}

# Extrait la première valeur string d'une clé JSON (sans jq)
json_str() {
    local key="$1"
    grep -o "\"${key}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" \
        | head -1 | sed 's/.*"\([^"]*\)"$/\1/' || true
}

get_latest_release() {
    local owner="$1" repo="$2"
    local json
    json=$(github_api "https://api.github.com/repos/${owner}/${repo}/releases/latest" 2>/dev/null) || json=""
    echo "$json" | json_str "tag_name"
}

get_latest_tag() {
    local owner="$1" repo="$2"
    local json
    json=$(github_api "https://api.github.com/repos/${owner}/${repo}/tags" 2>/dev/null) || json=""
    echo "$json" | json_str "name"
}

get_latest_commit() {
    local owner="$1" repo="$2"
    local json
    json=$(github_api "https://api.github.com/repos/${owner}/${repo}/commits/HEAD" 2>/dev/null) || json=""
    echo "$json" | json_str "sha"
}

strip_v() { echo "${1#v}"; }

# ── Affichage ─────────────────────────────────────────────────────────────────
print_package() {
    local name="$1" owner="$2" repo="$3" current="$4" type="$5" file="$6"

    printf "\n  📦 ${BOLD}%-36s${NC} ${DIM}%s/%s${NC}\n" "$name" "$owner" "$repo"
    printf "     ${DIM}%s${NC}\n" "$file"

    if [[ "$type" == "commit" ]]; then
        local latest
        latest=$(get_latest_commit "$owner" "$repo")

        if [[ -z "$latest" ]]; then
            printf "     ❌ ${RED}Erreur API ou dépôt introuvable${NC}\n"
            errors=$((errors + 1)); return
        fi

        if [[ "$current" == "$latest" ]]; then
            printf "     ✅ ${GREEN}À jour${NC} ${DIM}(commit %.8s)${NC}\n" "$current"
            up_to_date=$((up_to_date + 1))
        else
            printf "     🔀 ${YELLOW}Nouveau commit dispo${NC}: ${DIM}%.8s${NC} → ${BOLD}${GREEN}%.8s${NC}\n" \
                "$current" "$latest"
            outdated=$((outdated + 1))
        fi
    else
        local latest
        latest=$(get_latest_release "$owner" "$repo")
        [[ -z "$latest" ]] && latest=$(get_latest_tag "$owner" "$repo")

        if [[ -z "$latest" ]]; then
            printf "     ❌ ${RED}Aucune release/tag trouvée${NC}\n"
            errors=$((errors + 1)); return
        fi

        local cur_v lat_v
        cur_v=$(strip_v "$current")
        lat_v=$(strip_v "$latest")

        if [[ "$cur_v" == "$lat_v" ]]; then
            printf "     ✅ ${GREEN}À jour${NC} ${DIM}(v%s)${NC}\n" "$cur_v"
            up_to_date=$((up_to_date + 1))
        else
            printf "     ⬆️  ${YELLOW}Mise à jour dispo${NC}: ${BOLD}v%s${NC} → ${BOLD}${GREEN}v%s${NC}\n" \
                "$cur_v" "$lat_v"
            outdated=$((outdated + 1))
        fi
    fi
}

# ── Parsing ───────────────────────────────────────────────────────────────────

# Résout ${version} en cherchant `version = "X.Y.Z"` dans le même répertoire
resolve_version() {
    local value="$1" dir="$2"
    [[ "$value" != *'${version}'* ]] && { echo "$value"; return; }

    local ver
    ver=$(grep -hroE 'version[[:space:]]*=[[:space:]]*"[0-9][^"]*"' "$dir"/ 2>/dev/null \
        | head -1 | grep -oE '"[^"]+"' | tr -d '"')

    [[ -z "$ver" ]] && { echo ""; return; }
    echo "${value//\$\{version\}/$ver}"
}

# Extrait les blocs fetchFromGitHub : "owner|repo|rev" par résultat
parse_fetch_from_github() {
    local file="$1"
    gawk '
    /fetchFromGitHub[[:space:]]*\{/ {
        in_block=1; depth=0; owner=""; repo=""; rev=""
    }
    in_block {
        n = split($0, c, "")
        for (i=1; i<=n; i++) {
            if (c[i] == "{") depth++
            if (c[i] == "}") {
                depth--
                if (depth == 0) {
                    if (owner!="" && repo!="" && rev!="")
                        print owner "|" repo "|" rev
                    in_block=0; break
                }
            }
        }
    }
    in_block && /^[[:space:]]*owner[[:space:]]*=/ {
        line=$0; sub(/.*owner[[:space:]]*=[[:space:]]*"/, "", line)
        sub(/".*/, "", line); owner=line
    }
    in_block && /^[[:space:]]*repo[[:space:]]*=/ {
        line=$0; sub(/.*repo[[:space:]]*=[[:space:]]*"/, "", line)
        sub(/".*/, "", line); repo=line
    }
    in_block && /^[[:space:]]*rev[[:space:]]*=/ {
        line=$0; sub(/.*rev[[:space:]]*=[[:space:]]*"/, "", line)
        sub(/".*/, "", line); rev=line
    }
    ' "$file"
}

# Extrait les URLs GitHub (releases/download et archive/refs/tags), hors commentaires
parse_github_urls() {
    local file="$1"
    grep -v '^\s*#' "$file" 2>/dev/null \
        | grep -oE 'https://github\.com/[^"]+' \
        | grep -E '/(releases/download|archive/refs/tags)/'
}

# Traite un fichier nix
process_file() {
    local file="$1"
    local rel_file="${file#"${NIXOS_DIR}"/}"
    local name
    name=$(basename "$(dirname "$file")")

    # fetchFromGitHub ─────────────────────────────────────────────────────────
    while IFS='|' read -r owner repo rev; do
        [[ -z "$owner" || -z "$repo" || -z "$rev" ]] && continue

        local key="${owner}/${repo}"
        [[ -v seen["$key"] ]] && continue
        seen["$key"]=1

        local type version
        if [[ "$rev" =~ ^[0-9a-f]{40}$ ]]; then
            type="commit"
            version="$rev"
        else
            type="release"
            version=$(resolve_version "$rev" "$(dirname "$file")")
            [[ -z "$version" || "$version" == *'${'* ]] && continue
        fi

        print_package "$name" "$owner" "$repo" "$version" "$type" "$rel_file"
    done < <(parse_fetch_from_github "$file")

    # fetchurl / builtins.fetchTarball ────────────────────────────────────────
    while IFS= read -r url; do
        local owner repo version

        owner=$(sed 's|https://github.com/\([^/]*\)/.*|\1|' <<< "$url")
        repo=$(sed  's|https://github.com/[^/]*/\([^/]*\)/.*|\1|' <<< "$url")

        local key="${owner}/${repo}"
        [[ -v seen["$key"] ]] && continue
        seen["$key"]=1

        if [[ "$url" == *"/releases/download/"* ]]; then
            version=$(sed 's|.*/releases/download/\([^/]*\)/.*|\1|' <<< "$url")
        else
            version=$(sed 's|.*/tags/\([^.]*\)\..*|\1|' <<< "$url")
        fi

        version=$(resolve_version "$version" "$(dirname "$file")")
        [[ -z "$version" || "$version" == *'${'* ]] && continue

        print_package "$name" "$owner" "$repo" "$version" "release" "$rel_file"
    done < <(parse_github_urls "$file")
}

# ── Entête ────────────────────────────────────────────────────────────────────
printf "\n${BOLD}${BLUE}╔══════════════════════════════════════════════╗\n${NC}"
printf   "${BOLD}${BLUE}║   NixOS · GitHub Update Checker              ║\n${NC}"
printf   "${BOLD}${BLUE}╚══════════════════════════════════════════════╝\n${NC}"
printf "  ${DIM}Répertoire : %s${NC}\n" "$NIXOS_DIR"

if [[ -n "$GITHUB_TOKEN" ]]; then
    printf "  ${DIM}Token      : configuré ✓${NC}\n"
else
    printf "  ${YELLOW}⚠️  GITHUB_TOKEN absent — rate limit : 60 req/h${NC}\n"
fi

# ── Scan ──────────────────────────────────────────────────────────────────────
declare -A seen

while IFS= read -r file; do
    process_file "$file"
done < <(
    grep -rl \
        -e "fetchFromGitHub" \
        -e "github\.com.*releases/download" \
        -e "github\.com.*archive/refs/tags" \
        --include="*.nix" \
        "$NIXOS_DIR" \
    | sort
)

# ── Résumé ────────────────────────────────────────────────────────────────────
printf "\n${BOLD}${BLUE}┌──────────────────────────────────┐\n${NC}"
printf   "${BOLD}${BLUE}│           Résumé                 │\n${NC}"
printf   "${BOLD}${BLUE}├──────────────────────────────────┤\n${NC}"
printf   "${BOLD}${BLUE}│${NC} ✅ À jour         : ${GREEN}${BOLD}%-4d${NC}         ${BOLD}${BLUE}│\n${NC}" "$up_to_date"
printf   "${BOLD}${BLUE}│${NC} ⬆️  Mises à jour   : ${YELLOW}${BOLD}%-4d${NC}         ${BOLD}${BLUE}│\n${NC}" "$outdated"
printf   "${BOLD}${BLUE}│${NC} ❌ Erreurs        : ${RED}${BOLD}%-4d${NC}         ${BOLD}${BLUE}│\n${NC}" "$errors"
printf   "${BOLD}${BLUE}└──────────────────────────────────┘\n${NC}"
printf "\n"
