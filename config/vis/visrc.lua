-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/textobject-lexer')
require('plugins/vis-cursors/cursors').cursors_path = string.format('%s/vis/cursors', os.getenv('XDG_DATA_HOME') or os.getenv('HOME').."/.local/share")
require('plugins/vis-spellcheck/spellcheck')
require('plugins/vis-commentary/vis-commentary')
-- This hooks vis.events.START so its fine to load it before the default settings
require('plugins/vis-modelines/vis-modelines')

require('plugins/suw')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	local theme = "default"
	if string.match(os.getenv('TERM'), '^st.*') then
		theme = "st"
	end
	vis:command("set theme ".. theme .. (vis.ui.colors <= 16 and "-16" or "-256"))
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Default settings
	vis:command('set tabwidth 4')
	vis:command('set autoindent')
	vis:command('set number')
	vis:command('set colorcolumn 80')
	vis:command('set show-tabs')

	if win.file.name then
		if win.file.name:find("COMMIT_EDITMSG") then
			vis:command('set colorcolumn 72')
			win:set_syntax("diff")
		end

		if win.syntax == "python" then
			vis:command("set expand")
		end
	end
end)

-- load plugins that hook WIN_OPEN to change settings after hook with default settings
require('plugins/vis-editorconfig/editorconfig')

--vis.events.subscribe(vis.events.FILE_SAVE_PRE, function(file)
	---- purge trailing whitespace
	--local i = 1
	--while i <= #file.lines do
		--file.lines[i] = file.lines[i]:match("(.-)%s*$")
		--i = i + 1
	--end
    --return true
--end)
