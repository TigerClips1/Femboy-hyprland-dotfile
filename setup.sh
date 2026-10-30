#!/usr/bin/env bash
# Femboy Hyprland dotfiles: installer for Arch Linux and derivatives.
#
# Default: installs packages only (same behaviour as before). Config files are
# only touched when you pass --link or --copy, and anything that already exists
# is moved to ~/.dotfiles-backup/<timestamp>/ first.
#
# Run ./setup.sh --help for options.

set -Eeuo pipefail
trap 'echo "setup.sh failed on line $LINENO." >&2' ERR

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# ---------------------------------------------------------------- options ---
PACKAGES=1
OPTIONAL=1
AUR=1
UPGRADE=1
MODE=""        # "", link, copy
LY=0
YES=0
DRY=0

usage() {
  cat <<'EOF'
Usage: ./setup.sh [options]

Packages (Arch / pacman only):
  --no-optional   skip optional apps (firefox, gedit, dolphin, ly, onlyoffice, vesktop)
  --no-aur        skip every package that is not in the official repos
  --no-upgrade    do not run a full system upgrade first (pacman -Syu)
  --no-packages   skip package installation entirely

Config files (off by default):
  --link          symlink the dotfiles into ~/.config (edits in the repo apply live)
  --copy          copy the dotfiles into ~/.config
  --ly            also install ly/ to /etc/ly (needs sudo, replaces your ly config)

General:
  -y, --yes       pass --noconfirm to pacman and the AUR helper
  -n, --dry-run   print what would happen, change nothing
  -h, --help      show this help

Existing files are moved to ~/.dotfiles-backup/<timestamp>/ before being replaced.
EOF
}

for arg in "$@"; do
  case "$arg" in
    --no-optional) OPTIONAL=0 ;;
    --no-aur)      AUR=0 ;;
    --no-upgrade)  UPGRADE=0 ;;
    --no-packages) PACKAGES=0 ;;
    --link)        MODE=link ;;
    --copy)        MODE=copy ;;
    --ly)          LY=1 ;;
    -y|--yes)      YES=1 ;;
    -n|--dry-run)  DRY=1 ;;
    -h|--help)     usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage >&2; exit 1 ;;
  esac
done

# ---------------------------------------------------------------- helpers ---
info() { printf '\033[1;35m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m  %s\n' "$*" >&2; }
die()  { printf '\033[1;31mxx\033[0m  %s\n' "$*" >&2; exit 1; }

run() {
  if [[ $DRY -eq 1 ]]; then
    printf '  [dry-run]'; printf ' %q' "$@"; printf '\n'
  else
    "$@"
  fi
}

CONFIRM=()
if [[ $YES -eq 1 ]]; then CONFIRM=(--noconfirm); fi

# ----------------------------------------------------------------- checks ---
if [[ $EUID -eq 0 ]]; then
  die "Run as a regular user, not root; sudo is used where needed."
fi

if [[ $PACKAGES -eq 1 ]] && ! command -v pacman >/dev/null 2>&1; then
  die "Package install only supports Arch-based distros (pacman not found). Use --no-packages to skip."
fi

if [[ -n $MODE ]]; then
  case "$REPO_DIR" in
    "$CONFIG_DIR"|"$CONFIG_DIR"/*)
      die "The repo is inside $CONFIG_DIR. Clone it somewhere else (e.g. ~/Femboy-hyprland-dotfile) before using --$MODE." ;;
  esac
fi

# --------------------------------------------------------------- packages ---
# Names only; the script works out at runtime whether each one comes from the
# official repos or the AUR, so this list does not go stale when a package moves.

PKG_CORE=(
  # Hyprland session
  hyprland hyprpaper hypridle hyprlock hyprsunset hyprlauncher hyprpicker hyprshot
  xdg-desktop-portal xdg-desktop-portal-hyprland
  # terminal, prompt, system tools
  kitty starship fastfetch btop cava rofi superfile
  # clipboard, media, audio
  cliphist wl-clipboard playerctl
  pipewire pipewire-pulse wireplumber easyeffects
  # font
  ttf-jetbrains-mono-nerd
  # Qt theming (Qt5 needs its own Kvantum plugin)
  qt5ct qt6ct kvantum kvantum-qt5
  # Hyprland Lua config
  lua
  # screenshots, notifications, keybind helpers
  grim jq bc libnotify xdg-user-dirs
  # ashell: updates, network, bluetooth, brightness
  pacman-contrib alacritty networkmanager nm-connection-editor
  bluez bluez-utils bluetui brightnessctl
  # AUR
  ashell pipemixer bibata-cursor-theme
)

# Referenced by keybinds, mimeapps and autostart
PKG_OPTIONAL=(firefox gedit dolphin ly onlyoffice-bin vesktop-bin)

REPO_PKGS=()
AUR_PKGS=()

route_packages() {
  local p
  REPO_PKGS=(); AUR_PKGS=()
  for p in "$@"; do
    if pacman -Si -- "$p" >/dev/null 2>&1; then
      REPO_PKGS+=("$p")
    else
      AUR_PKGS+=("$p")
    fi
  done
}

find_aur_helper() {
  local h
  for h in paru yay; do
    if command -v "$h" >/dev/null 2>&1; then echo "$h"; return 0; fi
  done
  return 1
}

install_aur_helper() {
  info "No AUR helper found, building paru-bin"
  run sudo pacman -S --needed "${CONFIRM[@]}" base-devel git
  local tmp
  tmp="$(mktemp -d)"
  run git clone https://aur.archlinux.org/paru-bin.git "$tmp/paru-bin"
  if [[ $DRY -eq 1 ]]; then
    printf '  [dry-run] (cd %q && makepkg -si)\n' "$tmp/paru-bin"
  else
    (cd "$tmp/paru-bin" && makepkg -si "${CONFIRM[@]}")
  fi
  rm -rf "$tmp"
}

install_packages() {
  local all=("${PKG_CORE[@]}")
  if [[ $OPTIONAL -eq 1 ]]; then all+=("${PKG_OPTIONAL[@]}"); fi

  if [[ $UPGRADE -eq 1 ]]; then
    info "Syncing databases and upgrading the system"
    run sudo pacman -Syu "${CONFIRM[@]}"
  else
    warn "Skipping system upgrade; package lookup uses your current sync databases."
  fi

  route_packages "${all[@]}"

  if [[ ${#REPO_PKGS[@]} -gt 0 ]]; then
    info "Installing from the official repos: ${REPO_PKGS[*]}"
    run sudo pacman -S --needed "${CONFIRM[@]}" "${REPO_PKGS[@]}"
  fi

  if [[ ${#AUR_PKGS[@]} -gt 0 ]]; then
    if [[ $AUR -eq 0 ]]; then
      warn "Skipped AUR packages (--no-aur): ${AUR_PKGS[*]}"
      return 0
    fi
    local helper
    helper="$(find_aur_helper || true)"
    if [[ -z $helper ]]; then
      install_aur_helper
      helper=paru
    fi
    info "Installing from the AUR with $helper: ${AUR_PKGS[*]}"
    run "$helper" -S --needed "${CONFIRM[@]}" "${AUR_PKGS[@]}"
  fi
}

# ----------------------------------------------------------- config files ---
# "path inside the repo" -> "destination". Remove a line if you do not want it.
# Directories whose repo copy only holds a subfolder (fish, vesktop,
# oomox-qtstyleplugin) link just that subfolder so your other files survive.
LINKS=(
  "Kvantum:$CONFIG_DIR/Kvantum"
  "ashell:$CONFIG_DIR/ashell"
  "autostart:$CONFIG_DIR/autostart"
  "btop:$CONFIG_DIR/btop"
  "cava:$CONFIG_DIR/cava"
  "drwrap:$CONFIG_DIR/drwrap"
  "environment.d:$CONFIG_DIR/environment.d"
  "fastfetch:$CONFIG_DIR/fastfetch"
  "fish/completions:$CONFIG_DIR/fish/completions"
  "gedit:$CONFIG_DIR/gedit"
  "godot:$CONFIG_DIR/godot"
  "gtk-3.0:$CONFIG_DIR/gtk-3.0"
  "gtk-4.0:$CONFIG_DIR/gtk-4.0"
  "htop:$CONFIG_DIR/htop"
  "hypr:$CONFIG_DIR/hypr"
  "kitty:$CONFIG_DIR/kitty"
  "lact:$CONFIG_DIR/lact"
  "mako:$CONFIG_DIR/mako"
  "millennium:$CONFIG_DIR/millennium"
  "oomox:$CONFIG_DIR/oomox"
  "oomox-qtstyleplugin/themes:$CONFIG_DIR/oomox-qtstyleplugin/themes"
  "openvr:$CONFIG_DIR/openvr"
  "paru:$CONFIG_DIR/paru"
  "qt5ct:$CONFIG_DIR/qt5ct"
  "qt6ct:$CONFIG_DIR/qt6ct"
  "rofi:$CONFIG_DIR/rofi"
  "superfile:$CONFIG_DIR/superfile"
  "swayosd:$CONFIG_DIR/swayosd"
  "vesktop/themes:$CONFIG_DIR/vesktop/themes"
  "wivrn:$CONFIG_DIR/wivrn"
  "wleave:$CONFIG_DIR/wleave"
  "starship.toml:$CONFIG_DIR/starship.toml"
  "mimeapps.list:$CONFIG_DIR/mimeapps.list"
)

backup() {
  local target="$1" rel
  rel="${target#"$HOME"/}"
  run mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
  run mv -- "$target" "$BACKUP_DIR/$rel"
}

place() {
  local rel="$1" dest="$2" src="$REPO_DIR/$1"

  if [[ ! -e $src ]]; then
    warn "Not in repo, skipped: $rel"
    return 0
  fi

  if [[ $MODE == link && -L $dest && "$(readlink -f -- "$dest")" == "$(readlink -f -- "$src")" ]]; then
    echo "  ok      $rel (already linked)"
    return 0
  fi

  if [[ -e $dest || -L $dest ]]; then
    backup "$dest"
  fi

  run mkdir -p "$(dirname "$dest")"
  if [[ $MODE == link ]]; then
    run ln -s -- "$src" "$dest"
    echo "  linked  $rel"
  else
    run cp -a -- "$src" "$dest"
    echo "  copied  $rel"
  fi
}

install_configs() {
  info "Installing configs into $CONFIG_DIR ($MODE)"
  local entry
  for entry in "${LINKS[@]}"; do
    place "${entry%%:*}" "${entry#*:}"
  done

  if [[ -d $REPO_DIR/wallpaper ]]; then
    info "Copying wallpapers to ~/Pictures/Wallpaper (existing files are kept)"
    run mkdir -p "$HOME/Pictures/Wallpaper"
    run cp -rn -- "$REPO_DIR/wallpaper/." "$HOME/Pictures/Wallpaper/"
  fi

  if [[ -d $BACKUP_DIR ]]; then
    info "Replaced files were backed up to $BACKUP_DIR"
  fi
}

install_ly() {
  if [[ ! -d $REPO_DIR/ly ]]; then
    warn "No ly/ directory in the repo, skipped."
    return 0
  fi
  info "Installing ly config to /etc/ly"
  if [[ -e /etc/ly ]]; then
    run mkdir -p "$BACKUP_DIR"
    run cp -a /etc/ly "$BACKUP_DIR/etc-ly"
  fi
  run sudo mkdir -p /etc/ly
  run sudo cp -r "$REPO_DIR/ly/." /etc/ly/
}

make_scripts_executable() {
  local dir script
  shopt -s nullglob
  for dir in "$REPO_DIR" "$CONFIG_DIR"; do
    for script in "$dir"/hypr/scripts/*.sh "$dir"/hypr/hyprlock/*.sh; do
      if [[ -f $script ]]; then run chmod +x -- "$script"; fi
    done
  done
  shopt -u nullglob
}

# ------------------------------------------------------------------- main ---
if [[ $DRY -eq 1 ]]; then warn "Dry run: nothing will be changed."; fi

if [[ $PACKAGES -eq 1 ]]; then install_packages; fi
if [[ -n $MODE ]]; then install_configs; fi
if [[ $LY -eq 1 ]]; then install_ly; fi

make_scripts_executable
run mkdir -p "$HOME/Pictures/Wallpaper"

cat <<'EOF'

Done. Next steps:
  - Set your monitor name and wallpaper path in hypr/ (hyprpaper.conf and the monitor config).
    Find the monitor name with: hyprctl monitors
  - Drop your wallpaper into ~/Pictures/Wallpaper.
  - Wi-Fi and Bluetooth in the bar need services running:
      sudo systemctl enable --now NetworkManager.service bluetooth.service
    (skip NetworkManager if you use iwd or systemd-networkd)
  - Optional login manager: sudo systemctl enable ly@tty2.service
  - If you did not use --link or --copy, put the configs in ~/.config yourself (see README).
EOF