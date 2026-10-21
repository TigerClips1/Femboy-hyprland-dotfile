#!/usr/bin/env bash
# Installs the packages these dotfiles depend on (Arch Linux and derivatives).
# Usage: ./setup.sh [--no-optional] [--no-aur]
set -euo pipefail

OPTIONAL=1
AUR=1
for arg in "$@"; do
    case "$arg" in
        --no-optional) OPTIONAL=0 ;;
        --no-aur) AUR=0 ;;
        -h|--help)
            sed -n '2,3p' "$0" | sed 's/^# \?//'
            exit 0 ;;
        *) echo "Unknown option: $arg" >&2; exit 1 ;;
    esac
done

if [[ $EUID -eq 0 ]]; then
    echo "Run as a regular user, not root; sudo is used where needed." >&2
    exit 1
fi

if ! command -v pacman >/dev/null 2>&1; then
    echo "This script only supports Arch-based distributions (pacman not found)." >&2
    exit 1
fi

# Core: Hyprland session, bar, launcher, clipboard, audio, terminal and CLI tools
REPO_CORE=(
    hyprland hyprpaper hypridle hyprlock hyprsunset hyprlauncher hyprpicker hyprshot
    xdg-desktop-portal xdg-desktop-portal-hyprland
    kitty starship fastfetch btop cava rofi superfile
    cliphist wl-clipboard playerctl
    pipewire pipewire-pulse wireplumber easyeffects
    ttf-jetbrains-mono-nerd
    lua
)
AUR_CORE=(ashell pipemixer bibata-cursor-theme)

# Applications referenced by keybinds, mimeapps and autostart
REPO_OPTIONAL=(firefox gedit dolphin ly)
AUR_OPTIONAL=(onlyoffice-bin vesktop-bin)

install_repo() {
    sudo pacman -S --needed "$@"
}

install_aur() {
    local helper=""
    for h in paru yay; do
        command -v "$h" >/dev/null 2>&1 && { helper="$h"; break; }
    done

    if [[ -z "$helper" ]]; then
        echo "Installing paru (AUR helper)..."
        sudo pacman -S --needed base-devel git
        local tmp
        tmp="$(mktemp -d)"
        git clone https://aur.archlinux.org/paru-bin.git "$tmp/paru-bin"
        (cd "$tmp/paru-bin" && makepkg -si)
        rm -rf "$tmp"
        helper=paru
    fi

    "$helper" -S --needed "$@"
}

echo "==> Installing core packages"
install_repo "${REPO_CORE[@]}"

if [[ $OPTIONAL -eq 1 ]]; then
    echo "==> Installing optional applications"
    install_repo "${REPO_OPTIONAL[@]}"
fi

if [[ $AUR -eq 1 ]]; then
    aur_pkgs=("${AUR_CORE[@]}")
    [[ $OPTIONAL -eq 1 ]] && aur_pkgs+=("${AUR_OPTIONAL[@]}")
    echo "==> Installing AUR packages: ${aur_pkgs[*]}"
    install_aur "${aur_pkgs[@]}"
else
    echo "Skipped AUR packages: ${AUR_CORE[*]} ${AUR_OPTIONAL[*]}"
fi

# Helper scripts referenced by the Hyprland config must be executable
chmod +x "$HOME"/.config/hypr/scripts/*.sh "$HOME"/.config/hypr/hyprlock/*.sh 2>/dev/null || true

mkdir -p "$HOME/Pictures/Wallpaper"

echo
echo "Done. Next steps:"
echo "  - Put your wallpaper in ~/Pictures/Wallpaper and update hypr/hyprpaper.conf (monitor name too)."
echo "  - Optionally enable the display manager: sudo systemctl enable ly@tty2.service"
