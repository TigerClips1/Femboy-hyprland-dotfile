-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--

local home = os.getenv("HOME")

hl.on("hyprland.start", function () 
    -- Portals, wallpaper, launcher, idle handling, status bar, night light
    hl.exec_cmd(home .. "/.config/hypr/scripts/femboyflag_border.sh")
    hl.exec_cmd(home .. "/.config/hypr/scripts/xdg-fix.sh")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprlauncher --daemon")
    -- Execute each background process in its own individual call
    hl.exec_cmd("hypridle")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Create the desktop notification
    hl.notification.create({
        text = "Autostart complete",
        timeout = 5000
    })

    -- Export the session environment to D-Bus/systemd so portals and services see it
    hl.exec_cmd("dbus-update-activation-environment --all")
    
    -- Refresh theme variables after startup so systemd-activated Qt apps inherit them.
    hl.exec_cmd("sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_STYLE_OVERRIDE QT_QPA_PLATFORMTHEME")
    hl.exec_cmd("ashell")
    hl.exec_cmd("hyprsunset")

    -- Audio
    hl.exec_cmd("sleep 3 && flatpak run com.github.wwmm.easyeffects --hide-window")
    
    -- Clipboard: history
    --hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("wl-paste --type text --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update'")
    hl.exec_cmd("wl-paste --type image --watch bash -c 'cliphist store && qs -c $qsConfig ipc call cliphistService update'")

    -- Cursor
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
    
end)
