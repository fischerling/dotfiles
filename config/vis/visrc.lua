-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/textobject-lexer')
local cursors = require('plugins/vis-cursors')
cursors.cursors_path = string.format('%s/vis/cursors',
  os.getenv('XDG_DATA_HOME') or
  os.getenv('HOME') .. "/.local/share")

local spellcheck = require('plugins/vis-spellcheck')
spellcheck.list_cmd = 'hunspell -l -d %s'
spellcheck.cmd = 'hunspell -d %s'

require('plugins/vis-commentary')
require('plugins/vis-ctags')
-- This hooks vis.events.START so its fine to load it before the default settings
require('plugins/vis-modelines/vis-modelines')
local lspc = require('plugins/vis-lspc')
if next(lspc) then
  lspc.logging = true
  lspc.message_level = 2
  lspc.ls_map.latex = { name = 'latex', cmd = 'texlab' }
  lspc.ls_map.html = { name = 'html', cmd = 'vscode-html-languageserver --stdio' }
  lspc.ls_map.typescript = { name = 'typescript', cmd = 'typescript-language-server --stdio' }
  lspc.ls_map.java = { name = 'java', cmd = 'jdtls' }
  lspc.ls_map.ltex = {
    name = 'ltex',
    cmd = 'ltex-ls --no-endless',
    file_open_hook = function(ls, file)
      if not ls.settings then ls.settings = {} end
      if not ls.settings.ltex then ls.settings.ltex = {} end
      ls.settings.ltex.language = file.spelling_language:gsub('_', '-') or 'en-US'
    end
  }
end

local snippets = require('plugins/vis-snippets')
vis:map(vis.modes.NORMAL, "<C-s>", function()
	vis:command(':snippet')
end)

local build = require('plugins/vis-build')
build.get_default_build_cmd = function()
  if os.getenv('PWD'):match('Unterricht') then
    return "lesson-make"
  end
  return "make"
end

local fzf_open = require('plugins/vis-fzf-open')
fzf_open.fzf_path = "FZF_DEFAULT_COMMAND='rg --hidden -g !.git -l \"\"' fzf"

vis:map(vis.modes.NORMAL, ";o", function()
  vis:command('fzf')
end)

require('plugins/suw')

local theme = "theme"
vis.events.subscribe(vis.events.INIT, function()
  -- Your global configuration options
  vis:command("set theme " .. theme)
end)

local inotify = require('plugins/vis-inotify')
inotify.add_recreate_watch('/home/muhq/.config/vis/themes/theme.lua', function(msg)
  vis:command("set theme " .. theme) -- reload vis theme
end, '-P')

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
    elseif win.file.name:find('slides.md') then
      win:set_syntax('slides')
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
