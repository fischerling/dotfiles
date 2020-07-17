import os

# Keybindings
config.bind('x', 'spawn mpv {url}')
config.bind(',x', 'hint links spawn mpv {hint-url}')

config.bind('<Ctrl-l>', 'spawn --userscript password_fill')

c.editor.command = [os.environ["TERMINAL"], "-e", os.environ["VISUAL"], "{}"]

c.content.headers.do_not_track = True

# Disable javascript by default
config.set('content.javascript.enabled', False)

# Load autoconfig to enable javascript on trusted domains
config.load_autoconfig()

# Load theme
import theme

# set qutebrowser colors

for setting, color in theme.theme.items():
    config.set(setting, color)
