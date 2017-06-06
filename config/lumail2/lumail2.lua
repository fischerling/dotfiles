--
-- This is the per-user configuration file for lumail.
--

keymap['global']['gg'] = 'first()'
keymap['global']['G'] = 'last()'

-----------------------------------------------------------------------------

--
-- The following line enables *experimental* conversion of message-bodies
-- to UTF-8.
--
-- You might require this to be enabled if you receive mail in foreign
-- character-sets.  It should be harmless when enabled, but character-sets,
-- encoding, and similar, are scary and hard.  If you see garbled text,
-- unreadable emails, or similar problems with displaying message-bodies
-- comment it out as a first step in isolating the problem.
--
Config:set( "global.iconv", 1 )

--
-- Get our base-directories
--
local HOME = os.getenv("HOME")
local DATA_HOME = os.getenv("XDG_DATA_HOME") or HOME .. "/.local/share"
local CACHE_HOME = os.getenv("XDG_CONFIG_HOME") or HOME .. "/.cache"

--
-- The default Maildir location is ~/Maildir
--
Config:set( "maildir.prefix", HOME .. "/Mail" );

--
-- Handle both of my email accounts.
-- Determine the current account on basis of the folder path.
--

-- This is the account used by msmtp
local account = "fau"
-- Default name to use
Config:set("global.name", "Florian Fischer")
-- Default address.
Config:set("global.address", "florian.fl.fischer@fau.de")
-- Default From: address.
Config:set( "global.sender", "Florian Fischer <florian.fl.fischer@fau.de>" )
-- Default sent-folder.
Config:set( "global.sent-mail", HOME.."/Mail/FAU/Sent")
-- Default trash-folder.
Config:set( "global.trash-mail", HOME.."/Mail/FAU/Trash")

function on_folder_changed(folder)
    local path = folder:path()
    if path:find("FAU") then
        account = "fau"
        Config:set("global.address", "florian.fl.fischer@fau.de")
        Config:set("global.sent-mail", HOME.."/Mail/FAU/Sent")
        Config:set( "global.trash-mail", HOME.."/Mail/FAU/Trash")
    elseif path:find("MUHQ") then
        account = "muhq"
        Config:set("global.address", "florian.fischer@muhq.space")
        Config:set("global.sent-mail", HOME.."/Mail/MUHQ/Sent")
        Config:set( "global.trash-mail", HOME.."/Mail/MUHQ/Trash")
    end
    -- update sender
    Config:set("global.sender", Config:get("global.name").." <"..Config:get("global.address")..">")
    -- update MTA.
    Config:set( "global.mailer", "/usr/bin/sendmail -t -a " .. account .. " -f " .. Config:get("global.address") )
end

--
-- Setup our MTA, the command which actually sends the mail.
--
Config:set( "global.mailer", "/usr/bin/sendmail -t -a " .. account .. " -f " .. Config:get("global.address") )

--
-- Setup our default editor, for compose/reply/forward operations.
--
local editor = os.getenv("VISUAL") or os.getenv("EDITOR") or "vi"
Config:set( "global.editor", editor .. " +/^$ ++8" )

--
-- Save persistant history of our input in the named file.
--
Config:set( "global.history", DATA_HOME .. "/lumail2/history" )

--
-- Configure a cache-prefix, and populate it
--
Config:set( "cache.prefix", CACHE_HOME .. "/lumail2/" )

-- Configure logging
Config:set( "log.path" , DATA_HOME .. "/.lumail2/log" )
Config:set ( "log.level", "")

-- Index mode - which shows the list of messages:
--
Config:set( "index.format",
            "[${4|flags}] ${2|message_flags} | ${10|date} | ${20|sender} | ${indent}${subject}" )
--
--  Options include:
--
--   date          -> The message date.
--   flags         -> The local flags.
--   id            -> Message-ID.
--   indent        -> Nesting character(s) for the display of threads.
--   message_flags -> The message-content flags (has attachment? is signed?).
--   number        -> The message number.
--   sender        -> The sender of the message: "Bob Smith <bob@example.com>"
--     email         -> bob@example.com
--     name          -> Bob Smith
--   subject       -> The message subject.

--
-- Set the default sorting method.  Valid choices are:
--
--  `file`   - Use the mtime of the files in the maildir.
--  `date`   - Read the `Date` header of the message(s) - slower than the
--             above method, but works on IMAP too.
--  `subject` - Sort by subject.
--  `from`    - Sort by sender.
--
sorting_method( "threads" )

Config:set("threads.sort", "date")

--
-- Unread messages/maildirs are drawn in red.
--
Config:set( "colour.unread", "red" )

--
-- This table contains colouring information, it is designed to allow
-- the user to override the colours used in the display easily.
--
colour_table = {}

--
-- Create a per-mode map for each known mode.
--
for i,o in ipairs(Global:modes()) do
   colour_table[o] = {}
end

--
-- Setup our colours - for Maildir-mode
--
colour_table['maildir'] = {
   ['Automated'] = 'yellow|underline',
   ['lists']     = 'green|bold',
}

-- Setup our colours - for index-mode
colour_table['index'] = {
   ['Florian Fischer'] = 'blue',
   ['Fischer']   = 'blue',
}

-- Setup our colours - for a message
colour_table['message'] = {
   -- headers
   ['^Subject:'] = 'yellow',
   ['^Date:']    = 'yellow',
   ['^From:']    = 'yellow',
   ['^To:']      = 'yellow',
   ['^Cc:']      = 'yellow',
   ['^Sent:']    = 'yellow',

   -- quoting, and nested quoting.
   ['^>%s*>%s*']   = 'green',
   ['^>%s*[^>%s]'] = 'blue',
   ['^>%s$']       = 'blue',
}

--
-- Include address book completion in on_complete
--
do
    local _on_complete = on_complete
    function on_complete(token)
        local res = _on_complete(token)

        local handle = io.popen("khard email --parsable " ..  token)
        local stdout = handle:read("*a")
        handle:close()

        local lines = {}

        local function insert_mailaddr(line)
            -- include @ to make sure match is email
            local mailaddr = line:match("([^%s]*@[^%s]*)%s")
            if mailaddr then
                table.insert(res, mailaddr)
            end
        end

        stdout:gsub("(.-)\r?\n", insert_mailaddr)

        return res
    end
end

--
-- Add Content-Type to the headers before sending
--
function on_message_send(path)
  local content = {}
  local added = false
  local is_header = "^%a+: .*"
  for l in io.lines(path) do
    -- If this message was replaced by mimegpg don't mess with it
    if (l == "-----BEGIN PGP SIGNATURE-----") or (l == "-----BEGIN PGP MESSAGE-----") then
      return
    end

    -- Find the last header.
    if not added
       and content[#content] and string.match(content[#content], is_header)
       and not string.match(l, is_header)
    then
      -- Append Content-Type to the headers.
      table.insert(content, "Content-Type: text/plain; charset=UTF-8\n")
      added = true
    end
    table.insert(content, l.."\n")
  end
  
  -- write the new content
  local m = io.open(path, "w")
  m:write(unpack(content))
  m:close()
end

