--- a module for writing to to a file by increasing privilege
-- @author [Alejandro Baez](https://twitter.com/a_baez)
-- @module suw

--- cmd for sudo write and quit
local suwq = function()
  local file = vis.win.file
  vis:command((", > sudo tee %s"):format(file.name))

  vis:command("q!")
end

--- cmd for sudo write
local suw = function()
  local file = vis.win.file
  vis:command((", > sudo tee %s"):format(file.name))

  vis.events.emit(vis.events.FILE_SAVE_PRE, function(...) return true end)
  vis.events.emit(vis.events.FILE_SAVE_POST, function(...)
    file.modified = false
  end)
end

local function main()
  local comment = "write to file with privilege"

  vis:command_register("suw", suw, comment)
  vis:command_register("suwq", suwq, comment .. " and quit")
end


return main()