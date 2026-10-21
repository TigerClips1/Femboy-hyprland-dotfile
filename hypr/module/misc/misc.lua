----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 0, -- variable refresh rate: 0 = off
        -- Wake the display on mouse movement or key press
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        -- Window swallowing (terminal hides while a GUI app it launched is open)
        enable_swallow = false,
        swallow_regex = "(foot|kitty|allacritty|Alacritty)",
        on_focus_under_fullscreen = 2,
        -- Let the lock screen recover if hyprlock crashes
        allow_session_lock_restore = true,
        session_lock_xray = true,
        initial_workspace_tracking = false,
        focus_on_activate = true
    },
})

-- hl.config({
--     groupbar = true,
--     font_weight = {
--             font_weight_active = {
--                 font_weight = "normal"
--             },
--             font_weight_inactive = {
                
--             }
--         },
-- })

