-- Shared helpers loaded by hyprland.lua
HOME = os.getenv("HOME")

-- Maps slot i (1..workspaceGroupSize) to a workspace id inside the group of
-- the active workspace, so keybinds jump within the current group of workspaces.
function workspace_in_group(i)
    local curr = hl.get_active_workspace().id
    local newVal = math.floor((curr - 1) / workspaceGroupSize) * workspaceGroupSize + i
    -- hl.notification.create({ text = "curr " .. curr .. " floor " .. math.floor(curr / 10) .. " new " .. newVal, duration = 5000 })
    return newVal
end