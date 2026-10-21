#!/bin/bash
# Animates the active window border by continuously rotating the gradient angle.
# Started once from autostart.lua.

angle=0

while true; do
    # Advance 2 degrees per frame, wrapping at 360
    angle=$(( (angle + 2) % 360 ))

    hyprctl eval "hl.config({ general = { col = { active_border = { colors = {\"rgb(d260a5)\", \"rgb(e4afcd)\", \"rgb(fefefe)\", \"rgb(57cef8)\", \"rgb(f1f1f1)\", \"rgb(e4afcd)\", \"rgb(d260a5)\"}, angle = $angle } } } })"

    sleep 0.02
done
