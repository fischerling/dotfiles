import os

# Keybindings
config.bind('x', 'spawn mpv {url}')
config.bind(',x', 'hint links spawn mpv {hint-url}')

config.bind('<Ctrl-l>', 'spawn --userscript password_fill')

terminal = os.environ['TERMINAL']
if terminal in ["st", "urxvt"]:
    c.editor.command = [terminal, "-e", os.environ['VISUAL'],  "{}"]
else:
    c.editor.command = [terminal, "-e", f"{os.environ['VISUAL']} {{}}"]

c.content.headers.do_not_track = True

# Disable javascript by default
config.set('content.javascript.enabled', False)

config.set('content.cookies.accept', 'no-3rdparty')

config.set('content.autoplay', False)

# Load autoconfig to enable javascript on trusted domains
config.load_autoconfig()

# Load theme
import theme

# set qutebrowser colors
for setting, color in theme.theme.items():
    config.set(setting, color)

# request dark mode from pages
config.set("colors.webpage.preferred_color_scheme", "dark")
