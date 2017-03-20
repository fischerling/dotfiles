-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/textobject-lexer')
require('plugins/vis-cursors/cursors').cursors_path = string.format('%s/vis/cursors', os.getenv('XDG_DATA_HOME') or os.getenv('HOME').."/.local/share")

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	--vis:command("set theme ".. (vis.ui.colors <= 16 and "default-16" or "default-256"))
	vis:command("set theme default")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set tabwidth 4')
	vis:command('set autoindent')
	vis:command('set colorcolumn 80')
	vis:command('set show-tabs')

	if win.file.name and win.file.name:find("COMMIT_EDITMSG") then
		vis:command('set colorcolumn 72')
		win.syntax = "diff"
	end
end)

--vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file)
	---- purge trailing whitespace
	--local i = 1
	--while i <= #file.lines do
		--file.lines[i] = file.lines[i]:match("(.-)%s*$")
		--i = i + 1
	--end
    --return true
--end)
