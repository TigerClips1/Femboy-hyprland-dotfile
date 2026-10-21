#!/bin/sh
# Restarts the XDG desktop portals so they pick up the Hyprland session
# environment; run once from autostart.lua.
sleep 1
killall -e xdg-desktop-portal-hyprland
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
