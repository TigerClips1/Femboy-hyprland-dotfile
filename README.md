# Femboy Hyprland dotfiles

Personal Linux desktop configuration, centered on Hyprland. The repository contains configurations for Hyprland and related utilities, along with selected application settings and themes.

## Contents

- `hypr/` — Hyprland Lua modules, compositor settings, and helper scripts
- `kitty/`, `starship.toml`, `fastfetch/`, `btop/`, `cava/` — terminal and system information tools
- `rofi/`, `superfile/`, `ashell/` — launcher, file manager, and shell-bar settings
- `ly/` — display manager configuration
- Other directories contain optional application settings and themes

## Use

These files are personal starting points, not a universal or automated installer. Clone the repository somewhere separate from `~/.config`, review the configuration, then copy or symlink only the files and directories for applications you use. Install each application and any referenced scripts or tools first.

Before enabling the Hyprland configuration, check the monitor name, wallpaper location, autostart commands, key bindings, and application choices in `hypr/`. Some settings depend on the installed applications and hardware.

## Privacy

Application profiles, browser data, credentials, device state, and machine-specific session files are intentionally excluded. Review changes and run `git status` before committing; do not add local state or secrets.

## License and credits

The repository is licensed under GPL-3.0; see [LICENSE](LICENSE). Third-party configurations, themes, and assets retain their original authorship and license terms. The Fastfetch configuration credits cybrcore's `cybr-fastfetch` project and scherrer-txt as noted in the configuration file.
