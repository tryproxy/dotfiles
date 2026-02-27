#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

sync_bash() {
  mkdir -p "$DOTFILES_DIR/bash"
  cp "$HOME/.bash_aliases" "$DOTFILES_DIR/bash/.bash_aliases"
  cp "$HOME/.bashrc" "$DOTFILES_DIR/bash/.bashrc"
  echo "Synced bash files -> $DOTFILES_DIR/bash"
}

sync_zed() {
  local zed_src="${HOME}/.config/zed"
  local zed_dst="$DOTFILES_DIR/zed"

  if [[ ! -d "$zed_src" ]]; then
    echo "Zed config directory not found: $zed_src" >&2
    exit 1
  fi

  mkdir -p "$zed_dst"
  cp "$zed_src/keymap.json" "$zed_dst/keymap.json"
  cp "$zed_src/settings.json" "$zed_dst/settings.json"
  echo "Synced zed files -> $zed_dst"
}

usage() {
  cat <<'USAGE'
Usage: ./sync.sh [flags]

Flags:
  -bash      sync ~/.bash_aliases and ~/.bashrc to ./bash/
  -zed       sync ~/.config/zed/{keymap.json,settings.json} to ./zed/
  -all       sync both bash and zed
  -h, --help show this help

Examples:
  ./sync.sh -bash
  ./sync.sh -zed
  ./sync.sh -bash -zed
  ./sync.sh -all
USAGE
}

if [[ $# -eq 0 ]]; then
  usage
  exit 1
fi

did_work=0
for arg in "$@"; do
  case "$arg" in
    -bash)
      sync_bash
      did_work=1
      ;;
    -zed)
      sync_zed
      did_work=1
      ;;
    -all)
      sync_bash
      sync_zed
      did_work=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown flag: $arg" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ "$did_work" -eq 0 ]]; then
  usage
  exit 1
fi
