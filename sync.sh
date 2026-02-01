#!/usr/bin/env bash
set -euo pipefail

# --- Config ---
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

# Explicit allowlist
DIRS=(
  hypr
  kitty
  waybar
  cava
  nvim
  Kvantum
  eww
  hyprlock
  hypridle
  hyprbucket
  gtk-3.0
  gtk-4.0
)

# Exclusions
EXCLUDES=(
  --exclude='.git'
  --exclude='.cache/'
  --exclude='Cache/'
  --exclude='cache/'
  --exclude='*.log'
  --exclude='*.tmp'
  --exclude='*.swp'
  --exclude='__pycache__/'
)

# --- Safety checks ---
if [[ ! -d "$CONFIG_DIR" ]]; then
  echo "ERROR: CONFIG_DIR not found: $CONFIG_DIR" >&2
  exit 1
fi

if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "ERROR: DOTFILES_DIR not found: $DOTFILES_DIR" >&2
  echo "Tip: set DOTFILES_DIR env var or clone to ~/dotfiles" >&2
  exit 1
fi

# Ensure DOTFILES_DIR looks like actual dotfiles repo
if [[ ! -f "$DOTFILES_DIR/README.md" || ! -f "$DOTFILES_DIR/setup.sh" ]]; then
  echo "ERROR: DOTFILES_DIR doesn't look like your dotfiles repo: $DOTFILES_DIR" >&2
  exit 1
fi

# --- Flags ---
DRY_RUN=0
NO_DELETE=0

usage() {
  cat <<EOF
Usage: ./sync.sh [--dry-run] [--no-delete]

--dry-run   Show what would change, without writing
--no-delete Do not delete files in repo that were removed from ~/.config
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  --dry-run)
    DRY_RUN=1
    shift
    ;;
  --no-delete)
    NO_DELETE=1
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "Unknown argument: $1"
    usage
    exit 1
    ;;
  esac
done

echo "== Syncing from: $CONFIG_DIR"
echo "== Syncing into: $DOTFILES_DIR"
echo

for dir in "${DIRS[@]}"; do
  SRC="$CONFIG_DIR/$dir"
  DEST="$DOTFILES_DIR/$dir"

  if [[ ! -d "$SRC" ]]; then
    echo "⚠ Skipping $dir (not found in ~/.config)"
    continue
  fi

  echo "-> Syncing $dir"
  mkdir -p "$DEST"

  RSYNC_ARGS=(-av "${EXCLUDES[@]}")
  if [[ $DRY_RUN -eq 1 ]]; then
    RSYNC_ARGS+=(--dry-run)
  fi
  if [[ $NO_DELETE -eq 0 ]]; then
    RSYNC_ARGS+=(--delete)
  fi

  rsync "${RSYNC_ARGS[@]}" "$SRC/" "$DEST/"
  echo
done

echo "✓ Sync complete"
