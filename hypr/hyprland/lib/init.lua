HOME = os.getenv("HOME")

function workspace_in_group(i)
    local ws = hl.get_active_workspace()
    local curr = ws and ws.id or 1
    return math.floor((curr - 1) / workspaceGroupSize) * workspaceGroupSize + i
end
