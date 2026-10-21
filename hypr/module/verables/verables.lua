---------------------
---- MY PROGRAMS ----
---------------------

-- Terminal, browser and other program choices used by keybinds.lua
-- Set programs that you use
_G.terminal    = "kitty"
_G.fileManager = "kitty -e spf" -- superfile inside kitty
_G.browser = "firefox"
_G.codeEditor = "code"
_G.officeSoftware = "onlyoffice"
_G.textEditor = "gedit"
_G.menu        = "hyprlauncher"
_G.volumeMixer = "pipemixer"
_G.taskManager = "btop"
_G.workspaceGroupSize = 10 -- workspaces per group (see workspace_in_group in hyprland/lib)
_G.random_wallpaper = os.getenv("HOME") .. "/.config/hypr/scripts/random_wallpaper.sh"

-- Apps
-- -- PULL REQUESTS ADDING MORE WILL NOT BE ACCEPTED, CONFIG FOR YOURSELF
-- settingsApp = "XDG_CURRENT_DESKTOP=gnome ~/.config/hypr/hyprland/scripts/launch_first_available.sh 'qs -p ~/.config/quickshell/$qsConfig/settings.qml' 'systemsettings' 'gnome-control-center' 'better-control'"
