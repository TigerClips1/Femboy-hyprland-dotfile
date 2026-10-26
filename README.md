# Femboy Hyprland dotfiles

![Alt text](https://www.digitalocean.com/api/static-content/v1/images?src=https%3A%2F%2Fassets.digitalocean.com%2Farticles%2Falligator%2Fboo.svg&token=3b393c4e6c647039515f968de472a17b4ff48f2082204b56512e8c13d1cd5e04 "a title")

Personal Linux desktop configuration, centered on Hyprland. The repository contains configurations for Hyprland and related utilities, along with selected application settings and themes.

## Contents

- `hypr/` — Hyprland Lua modules, compositor settings, and helper scripts
- `kitty/`, `starship.toml`, `fastfetch/`, `btop/`, `cava/` — terminal and system information tools
- `rofi/`, `superfile/`, `ashell/` — launcher, file manager, and shell-bar settings
- `Kvantum/`, `qt5ct/`, `qt6ct/`, `oomox/`, `oomox-qtstyleplugin/`, `gtk-4.0/` — Qt and GTK theme settings and palettes
- `ly/` — display manager configuration
- Other directories contain optional application settings and themes

## Use

These files are personal starting points, not a universal or automated installer. Clone the repository somewhere separate from `~/.config`, review the configuration, then copy or symlink only the files and directories for applications you use. Install each application and any referenced scripts or tools first.

On Arch Linux and derivatives, `./setup.sh` installs the core packages required by the configuration, including Qt theme tools. Optional applications can be omitted with `--no-optional`; AUR packages can be omitted with `--no-aur`. The script does not copy files into `~/.config`.

Before enabling the Hyprland configuration, check the monitor name, wallpaper location, autostart commands, key bindings, and application choices in `hypr/`. Some settings depend on the installed applications and hardware.

## Privacy

Application profiles, browser data, credentials, device state, and machine-specific session files are intentionally excluded. Review changes and run `git status` before committing; do not add local state or secrets.

## License and credits

The repository is licensed under GPL-3.0; see [LICENSE](LICENSE). Third-party configurations, themes, and assets retain their original authorship and license terms. The Fastfetch configuration credits cybrcore's `cybr-fastfetch` project and scherrer-txt as noted in the configuration file.
