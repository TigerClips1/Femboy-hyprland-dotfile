# Femboy Hyprland dotfiles

[![image](https://i.ibb.co/6ccqwgBk/image.png)](https://ibb.co/j99jfgRS)

My Hyprland desktop, themed after the femboy pride flag colors (pink, blue, white). Hyprland is configured in Lua, with matching themes for the bar, launcher, terminal, GTK and Qt.

More screenshots are in [`Screenshots/`](Screenshots).

> These are personal dotfiles, not a framework. Expect to edit the monitor name, wallpaper path and a few keybinds before it feels right on your machine.

## What's inside

| Path | What it is |
| --- | --- |
| `hypr/` | Hyprland Lua modules, hypridle, hyprlock, hyprpaper, helper scripts |
| `ashell/` | Status bar |
| `rofi/` | Launcher |
| `kitty/`, `starship.toml`, `fastfetch/`, `btop/`, `htop/`, `cava/` | Terminal and system tools |
| `superfile/` | TUI file manager |
| `mako/`, `swayosd/`, `wleave/` | Notifications, volume/brightness OSD, logout menu |
| `Kvantum/`, `qt5ct/`, `qt6ct/`, `oomox/`, `oomox-qtstyleplugin/`, `gtk-3.0/`, `gtk-4.0/` | Qt and GTK theming |
| `vesktop/themes/`, `millennium/` | Discord and Steam theming |
| `ly/` | Display manager config |
| `autostart/`, `environment.d/`, `mimeapps.list` | Autostart entries, session environment, default apps |
| `gedit/`, `godot/`, `lact/`, `paru/`, `openvr/`, `wivrn/`, `fish/completions/`, `drwrap/` | Optional per-app settings |
| `wallpaper/` | Wallpapers |
| `setup.sh` | Package installer and optional config linker |

## Requirements

- Arch Linux or an Arch-based distro. `setup.sh` uses `pacman`. On anything else, install the equivalents by hand.
- A recent Hyprland that supports Lua configs. If `hypr/` seems to be ignored, update Hyprland first.
- `git`, `sudo`, and a regular (non-root) user.

## Install

Clone it somewhere that is **not** `~/.config`:

```bash
git clone https://github.com/TigerClips1/Femboy-hyprland-dotfile.git ~/Femboy-hyprland-dotfile
cd ~/Femboy-hyprland-dotfile
```

Preview first, then run it:

```bash
./setup.sh --dry-run --link     # prints everything, changes nothing
./setup.sh --link               # install packages and symlink configs
```

`--link` symlinks the configs into `~/.config`, so editing a file in the repo changes your live setup and `git pull` updates it. Use `--copy` if you would rather have independent copies.

Anything already in the way is moved to `~/.dotfiles-backup/<timestamp>/` before it is replaced, so nothing is deleted.

### `setup.sh` options

| Option | Effect |
| --- | --- |
| *(no options)* | Install packages only. Config files are not touched. |
| `--link` | Symlink the dotfiles into `~/.config` |
| `--copy` | Copy the dotfiles into `~/.config` |
| `--ly` | Also install `ly/` to `/etc/ly` (sudo, backs up the old one) |
| `--no-optional` | Skip optional apps: firefox, gedit, dolphin, ly, onlyoffice, vesktop |
| `--no-aur` | Skip every package that is not in the official repos |
| `--no-upgrade` | Do not run `pacman -Syu` first |
| `--no-packages` | Skip package installation, only handle configs |
| `-y`, `--yes` | Non-interactive (`--noconfirm`) |
| `-n`, `--dry-run` | Show what would happen without doing it |

The script sorts packages into official-repo and AUR at runtime, so it keeps working when a package moves between the two. If no AUR helper (`paru` or `yay`) is installed, it builds `paru-bin` for you.

### Manual install

If you only want some of it, skip `--link` and copy or symlink individual folders yourself:

```bash
ln -s ~/Femboy-hyprland-dotfile/hypr  ~/.config/hypr
ln -s ~/Femboy-hyprland-dotfile/kitty ~/.config/kitty
ln -s ~/Femboy-hyprland-dotfile/starship.toml ~/.config/starship.toml
```

Install the program a config belongs to before using that config. Make the helper scripts executable if `setup.sh` did not:

```bash
chmod +x ~/.config/hypr/scripts/*.sh ~/.config/hypr/hyprlock/*.sh
```

## After installing

1. **Monitor name.** Run `hyprctl monitors`, then update the monitor name in `hypr/` and in `hyprpaper.conf`.
2. **Wallpaper.** Put your image in `~/Pictures/Wallpaper` and point `hyprpaper.conf` at it.
3. **Services.** The bar's Wi-Fi and Bluetooth controls need these running:
   ```bash
   sudo systemctl enable --now NetworkManager.service bluetooth.service
   ```
   Skip `NetworkManager` if you use `iwd` or `systemd-networkd`.
4. **Login manager (optional).** `sudo systemctl enable ly@tty2.service`, or start Hyprland from a TTY.
5. **Check keybinds and autostart** in `hypr/`. Some of them launch apps you may not have installed.
6. **Qt theme.** Qt apps pick up the Kvantum theme through `qt5ct` and `qt6ct`. Log out and back in after the first install so the environment variables apply.

## Updating

```bash
cd ~/Femboy-hyprland-dotfile
git pull
./setup.sh --no-upgrade   # only needed if new packages were added
```

With `--link` there is nothing to copy. With `--copy`, run `./setup.sh --no-packages --copy` again (your old copies are backed up).

## Troubleshooting

- **Hyprland ignores the config:** your Hyprland is probably too old for Lua configs. Update it.
- **Bar or launcher is missing:** check that `ashell` and `hyprlauncher` are installed (`pacman -Q ashell hyprlauncher`).
- **No icons or squares in the bar:** install `ttf-jetbrains-mono-nerd`.
- **Qt apps look unstyled:** run `kvantummanager` and `qt6ct` and confirm the theme is selected.
- **`setup.sh` says the repo is inside `~/.config`:** move the clone out, linking a repo to itself breaks things.

## Privacy

Browser data, app profiles, credentials, device state and machine-specific session files are intentionally excluded. If you fork this, run `git status` before committing and never add local state or secrets.

## License and credits

GPL-3.0, see [LICENSE](LICENSE). Third-party configs, themes and assets keep their original authorship and licenses. The Fastfetch config credits cybrcore's `cybr-fastfetch` project and scherrer-txt, as noted in the config file.