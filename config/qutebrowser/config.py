import os

# Keybindings
config.bind('x', 'spawn mpv {url}')
config.bind(',x', 'hint links spawn mpv {hint-url}')

c.editor.command = [os.environ["TERMINAL"], "-e", "vim", "{}"]
