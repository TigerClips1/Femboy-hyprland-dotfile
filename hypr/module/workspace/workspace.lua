--------------------------------
---- WORKSPACES ----
--------------------------------

-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- hl.workspace_rule({ workspace = "3", no_rounding = true, decorate = false })
-- hl.workspace_rule({ workspace = "name:coding", no_rounding = true, decorate = false, gaps_in = 0, gaps_out = 0, no_border = true, monitor = "DP-1" })
-- hl.workspace_rule({ workspace = "8", border_size = 8 })
-- hl.workspace_rule({ workspace = "name:Hello", monitor = "DP-1", default = true })
-- hl.workspace_rule({ workspace = "name:gaming", monitor = "desc:Chimei Innolux Corporation 0x150C", default = true })
-- hl.workspace_rule({ workspace = "5", on_created_empty = "[float] firefox" })
-- hl.workspace_rule({ workspace = "special:scratchpad", on_created_empty = "foot" })
-- hl.workspace_rule({ workspace = "15", animation = "slidevert", default_name = "slider" })
-- Workspace 2 uses the scrolling layout, workspace 3 uses dwindle (others use the default layout)
hl.workspace_rule({ workspace = "2", layout = "scrolling" })
hl.workspace_rule({ workspace = "3", layout = "dwindle" })
