local M = {}
M.get_default_build_cmd = function() return 'make' end

local build_id = 0
local builds = {}

M.new_build = function(cmd)
    build_id = build_id + 1
    local build_name = 'build' .. build_id
    local build_fd = vis:communicate(build_name, cmd)
    local build = {fd = build_fd, out = '', err = '', cmd = cmd}
    builds[build_name] = build
end

vis.events.subscribe(vis.events.PROCESS_RESPONSE,
                     function(name, event, code, msg)
    local build = builds[name]
    if not build then return end

    if event == 'EXIT' or event == 'SIGNAL' then
        if code ~= 0 then
            vis:message('build: ' .. name .. ' cmd: ' .. build.cmd)
            if event == 'EXIT' then
                vis:message('failed with: ' .. code)
            else
                vis:message('got signal: ' .. code)
            end
            vis:message('stdout:\n' .. build.out)
            vis:message('stderr:\n' .. build.err)
        else
            vis:info(name .. ' done')
        end
        builds[name] = nil
    end

    if event == 'STDOUT' then
        build.out = build.out .. msg
    elseif event == 'STDERR' then
        build.err = build.err .. msg
    end
end)

vis:command_register('build', function(argv)
    M.new_build(argv[1] or M.get_default_build_cmd())
end, 'Asynchronously build the current file or project')

vis:map(vis.modes.NORMAL, '<M-b>', function()
    vis:command('build')
    return 0
end, 'Asynchronously build the current file or project')

return M
