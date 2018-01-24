import os

# Keybindings
config.bind('x', 'spawn mpv {url}')
config.bind(',x', 'hint links spawn mpv {hint-url}')

config.bind('<Ctrl-l>', 'spawn --userscript password_fill')

c.editor.command = [os.environ["TERMINAL"], "-e", "vim", "{}"]
