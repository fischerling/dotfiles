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
require('plugins/vis-ctags/ctags')
-- This hooks vis.events.START so its fine to load it before the default settings
require('plugins/vis-modelines/vis-modelines')
local lspc = require('plugins/vis-lspc')
if next(lspc) then
	lspc.logging = true
	lspc.ls_map.lua = {name = 'lua', cmd = 'lua-language-server'}
end

require('plugins/vis-fzf-open/fzf-open')
require('plugins/suw')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	local theme = "theme"
	vis:command("set theme ".. theme)
end)

-- seperate default settings into per file and per window to not override settings from
-- vis-editorconf which are set on FILE_OPEN
-- default file settings
vis.events.subscribe(vis.events.FILE_OPEN, function(file)
	tabwidth = 4
	vis:command('set tabwidth '..tabwidth)
	vis:command('set autoindent')
end)

-- load plugins that hook FILE_OPEN to change settings after hook with default settings
if vis:module_exist('editorconfig') then
	require('plugins/vis-editorconfig')
else
	vis:info('skip vis-editorconfig: editorconfig not available from lua')
end

-- default window settings
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set colorcolumn 80')
	vis:command('set show-tabs')
	if win.file.name then
		if win.file.name:find("COMMIT_EDITMSG") then
			vis:command('set colorcolumn 72')
			win:set_syntax("diff")
		elseif win.file.name:find('meson.build') and win.syntax ~= 'meson' then
			win:set_syntax('python')
		end

		if win.syntax == "python" or win.syntax == "rust" then
			vis:command('set expandtab')
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

vis:map(vis.modes.NORMAL, ";o", function()
	vis:command('fzf')
end)

vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")
