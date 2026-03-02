#!/usr/bin/env bash

set -euo pipefail

BACKUP_SUFFIX=".nix-override-backup"

cmd="${1:-}"
target="${2:-}"

usage() {
  echo "Usage: $0 override <file>"
  echo "       $0 revert <file>"
  exit 1
}

[[ -z "$cmd" || -z "$target" ]] && usage

case "$cmd" in
  override)
    if [[ -e "${target}${BACKUP_SUFFIX}" ]]; then
      echo "❌ A backup already exists at '${target}${BACKUP_SUFFIX}'. Already overridden?"
      exit 1
    fi

    if [[ ! -L "$target" ]]; then
      echo "❌ '$target' is not a symlink. Nothing to override."
      exit 1
    fi

    # Resolve the final target (follow all symlink chains)
    real_path=$(readlink -f "$target")

    if [[ ! -f "$real_path" ]]; then
      echo "❌ Resolved path '$real_path' is not a regular file."
      exit 1
    fi

    echo "🔗 Symlink chain: $target -> $real_path"

    # Move the symlink aside as backup
    mv "$target" "${target}${BACKUP_SUFFIX}"
    echo "📦 Symlink backed up as '${target}${BACKUP_SUFFIX}'"

    # Copy the real file content to the original path
    cp "$real_path" "$target"
    echo "✅ File created at '$target' (editable copy)"
    ;;

  revert)
    if [[ ! -e "${target}${BACKUP_SUFFIX}" ]]; then
      echo "❌ No backup found at '${target}${BACKUP_SUFFIX}'. Was this file overridden?"
      exit 1
    fi

    # Remove the temporary editable file
    rm -f "$target"
    echo "🗑️  Removed temporary file '$target'"

    # Restore the original symlink
    mv "${target}${BACKUP_SUFFIX}" "$target"
    echo "✅ Symlink restored at '$target'"
    ;;

  *)
    usage
    ;;
esac
