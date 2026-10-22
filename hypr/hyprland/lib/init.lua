HOME = os.getenv("HOME")

function workspace_in_group(i)
    local ws = hl.get_active_workspace()
    if not ws then
        return nil
    end

    local curr = ws.id
    local newVal = math.floor((curr - 1) / workspaceGroupSize) * workspaceGroupSize + i
    return newVal
end
