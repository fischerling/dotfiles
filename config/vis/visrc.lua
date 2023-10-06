-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/textobject-lexer')
local cursors = require('plugins/vis-cursors')
cursors.cursors_path = string.format('%s/vis/cursors',
                                     os.getenv('XDG_DATA_HOME') or
                                     os.getenv('HOME').."/.local/share")
require('plugins/vis-spellcheck')
require('plugins/vis-commentary')
require('plugins/vis-ctags')
-- This hooks vis.events.START so its fine to load it before the default settings
require('plugins/vis-modelines/vis-modelines')
local lspc = require('plugins/vis-lspc')
if next(lspc) then
	lspc.logging = true
	lspc.ls_map.latex = {name = 'latex', cmd = 'texlab'}
	lspc.ls_map.go = {name = 'go', cmd = 'gopls'}
end


local fzf_open = require('plugins/vis-fzf-open')

fzf_open.fzf_path = "FZF_DEFAULT_COMMAND='rg --hidden -g !.git -l \"\"' fzf"

vis:map(vis.modes.NORMAL, ";o", function()
	vis:command('fzf')
end)

require('plugins/suw')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	local theme = "theme"
	vis:command("set theme ".. theme)
end)

-- seperate default settings into per file and per window to not override settings from
-- vis-editorconf which are set on FILE_OPEN
-- default file settings
vis.events.subscribe(vis.events.FILE_OPEN, function()
	vis.options.autoindent = true
end)

-- default window settings
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	local tabwidth = 4
	win.options.tabwidth = tabwidth
	win.options.numbers = true
	win.options.showtabs = true
	win.options.colorcolumn = 80
	if win.file.name then
		if win.file.name:find("COMMIT_EDITMSG") then
			win.options.colorcolumn = 72
			win:set_syntax("diff")
		elseif win.file.name:find('meson.build') and win.syntax ~= 'meson' then
			win:set_syntax('python')
		end

		if win.syntax == "python" or win.syntax == "rust" then
			win.options.expandtab = true
			vis:map(vis.modes.INSERT, '<Backspace>', function()
				local found_tab = true
				for selection in vis.win:selections_iterator() do
					local pos = selection.pos
					if not pos or pos < tabwidth or vis.win.file:content(pos - tabwidth, tabwidth) ~= string.rep(' ', tabwidth) then
						found_tab = false
						break
					end
				end
				vis:feedkeys(string.rep('<vis-delete-char-prev>', found_tab and tabwidth or 1))
			end)
		end
	end
end)

-- load plugins that hook FILE_OPEN or WIN_OPEN to change settings after hooks
-- with default settings
if vis:module_exist('editorconfig') then
	require('plugins/vis-editorconfig')
else
	vis:info('skip vis-editorconfig: editorconfig not available from lua')
end


vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")

vis:command_register('lmk', function(argv)
	local cmd = '!lesson-make'
	for _, a in ipairs(argv) do
		cmd = cmd .. ' ' .. a
	end
	vis:command(cmd)
end)
