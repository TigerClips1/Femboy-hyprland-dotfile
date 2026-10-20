#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Picture"

CURRENT_WALL=$(hyprctl hyprpaper listloaded 2>/dev/null | head -n 1)
CURRENT_NAME=$(basename -- "$CURRENT_WALL")

WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_NAME" | shuf -n 1)

if [[ -z "$WALLPAPER" ]]; then
    echo "No different wallpaper found in $WALLPAPER_DIR" >&2
    exit 1
fi

hyprctl hyprpaper wallpaper ",$WALLPAPER"
