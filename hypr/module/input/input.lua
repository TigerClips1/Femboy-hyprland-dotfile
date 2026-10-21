---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        -- Key repeat: delay before repeating (ms) and repeats per second
        repeat_delay = 250,
        repeat_rate = 35,

        -- 1 = focus follows the mouse cursor
        follow_mouse = 1,
        off_window_axis_events = 2,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = true,
            clickfinger_behavior = true,
            scroll_factor = 0.7
        }
    },
    
    -- Render XWayland apps without scaling (avoids blurry text; apps handle scale themselves)
    xwayland = {
        force_zero_scaling = true
    },

    binds = {
        scroll_event_delay = 0,
        hide_special_on_workspace_change = true
    },
    -- Cursor zoom (used by the SUPER + -/= zoom keybinds)
      cursor = {
        zoom_factor = 1,
        zoom_rigid = false,
        zoom_disable_aa = true,
        hotspot_padding = 1
    },

    -- Touchpad swipe gesture tuning
    gestures = {
        workspace_swipe_distance = 700,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new = true
    },
})

-- Gestures: 3-finger swipe moves a window, 3-finger pinch toggles fullscreen,
-- 4-finger horizontal swipe switches workspace
hl.gesture({
    fingers = 3,
    direction = "swipe",
    action = "move"
})
hl.gesture({
    fingers = 3,
    direction = "pinch",
    action = "fullscreen"
})
hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace"
})



-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

