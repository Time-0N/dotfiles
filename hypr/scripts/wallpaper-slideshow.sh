#!/bin/bash

WALLPAPER_DIR="/home/timeon/Pictures/Wallpaper/slideshow"
INTERVAL=600
LOCKFILE="/tmp/wallpaper-slideshow.lock"

# Check if already running
if [ -f "$LOCKFILE" ]; then
    # Check if the PID in lockfile is still running
    if ps -p "$(cat "$LOCKFILE")" > /dev/null 2>&1; then
        exit 0
    fi
fi

# Create lockfile with current PID
echo $$ > "$LOCKFILE"

# Cleanup lockfile on exit
trap "rm -f $LOCKFILE" EXIT

# Wait for swww to be ready
sleep 3

# Get all wallpapers
WALLPAPERS=()
while IFS= read -r -d '' file; do
    WALLPAPERS+=("$file")
done < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0)

# Exit if no wallpapers found
[ ${#WALLPAPERS[@]} -eq 0 ] && exit 1

# Shuffle function using shuf
get_random_wallpaper() {
    printf '%s\n' "${WALLPAPERS[@]}" | shuf -n 1
}

# Apply wallpaper to all monitors
set_wallpaper() {
    local img="$1"
    local transition="$2"
    
    # Apply to all monitors at once
    swww img "$img" \
        --transition-type "$transition" \
        --transition-fps 120 \
        --transition-duration 1 \
        --resize crop \
        --filter CatmullRom
}

# Set initial wallpaper with no transition
CURRENT=$(get_random_wallpaper)
set_wallpaper "$CURRENT" "simple"

# Loop forever
while true; do
    sleep "$INTERVAL"
    
    # Get new random wallpaper (different from current if possible)
    NEXT=$(get_random_wallpaper)
    while [ "$NEXT" = "$CURRENT" ] && [ ${#WALLPAPERS[@]} -gt 1 ]; do
        NEXT=$(get_random_wallpaper)
    done
    
    set_wallpaper "$NEXT" "wipe"
    CURRENT="$NEXT"
done
