# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# Solarized Dark scheme by Ethan Schoonover (modified by aramisgithub)

base00 = "#002b36"
base01 = "#073642"
base02 = "#586e75"
base03 = "#657b83"
base04 = "#839496"
base05 = "#93a1a1"
base06 = "#eee8d5"
base07 = "#fdf6e3"
base08 = "#dc322f"
base09 = "#cb4b16"
base0A = "#b58900"
base0B = "#859900"
base0C = "#2aa198"
base0D = "#268bd2"
base0E = "#6c71c4"
base0F = "#d33682"

theme = {}

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
theme["colors.completion.fg"] = base05

# Background color of the completion widget for odd rows.
theme["colors.completion.odd.bg"] = base01

# Background color of the completion widget for even rows.
theme["colors.completion.even.bg"] = base00

# Foreground color of completion widget category headers.
theme["colors.completion.category.fg"] = base0A

# Background color of the completion widget category headers.
theme["colors.completion.category.bg"] = base00

# Top border color of the completion widget category headers.
theme["colors.completion.category.border.top"] = base00

# Bottom border color of the completion widget category headers.
theme["colors.completion.category.border.bottom"] = base00

# Foreground color of the selected completion item.
theme["colors.completion.item.selected.fg"] = base01

# Background color of the selected completion item.
theme["colors.completion.item.selected.bg"] = base0A

# Top border color of the selected completion item.
theme["colors.completion.item.selected.border.top"] = base0A

# Bottom border color of the selected completion item.
theme["colors.completion.item.selected.border.bottom"] = base0A

# Foreground color of the matched text in the selected completion item.
theme["colors.completion.item.selected.match.fg"] = base08

# Foreground color of the matched text in the completion.
theme["colors.completion.match.fg"] = base0B

# Background color of disabled items in the context menu.
theme["colors.contextmenu.disabled.bg"] = base01

# Foreground color of disabled items in the context menu.
theme["colors.contextmenu.disabled.fg"] = base04

# Color of the scrollbar handle in the completion view.
theme["colors.completion.scrollbar.fg"] = base05

# Color of the scrollbar in the completion view.
theme["colors.completion.scrollbar.bg"] = base00

# Background color of the context menu. If set to null, the Qt default is used.
theme["colors.contextmenu.menu.bg"] = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
theme["colors.contextmenu.menu.fg"] =  base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
theme["colors.contextmenu.selected.bg"] = base0A

#Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
theme["colors.contextmenu.selected.fg"] = base01

# Background color for the download bar.
theme["colors.downloads.bar.bg"] = base00

# Color gradient start for download text.
theme["colors.downloads.start.fg"] = base00

# Color gradient start for download backgrounds.
theme["colors.downloads.start.bg"] = base0D

# Color gradient end for download text.
theme["colors.downloads.stop.fg"] = base00

# Color gradient stop for download backgrounds.
theme["colors.downloads.stop.bg"] = base0C

# Foreground color for downloads with errors.
theme["colors.downloads.error.fg"] = base08

# Font color for hints.
theme["colors.hints.fg"] = base00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
theme["colors.hints.bg"] = base0A

# Font color for the matched part of hints.
theme["colors.hints.match.fg"] = base05

# Text color for the keyhint widget.
theme["colors.keyhint.fg"] = base05

# Highlight color for keys to complete the current keychain.
theme["colors.keyhint.suffix.fg"] = base05

# Background color of the keyhint widget.
theme["colors.keyhint.bg"] = base00

# Foreground color of an error message.
theme["colors.messages.error.fg"] = base00

# Background color of an error message.
theme["colors.messages.error.bg"] = base08

# Border color of an error message.
theme["colors.messages.error.border"] = base08

# Foreground color of a warning message.
theme["colors.messages.warning.fg"] = base00

# Background color of a warning message.
theme["colors.messages.warning.bg"] = base0E

# Border color of a warning message.
theme["colors.messages.warning.border"] = base0E

# Foreground color of an info message.
theme["colors.messages.info.fg"] = base05

# Background color of an info message.
theme["colors.messages.info.bg"] = base00

# Border color of an info message.
theme["colors.messages.info.border"] = base00

# Foreground color for prompts.
theme["colors.prompts.fg"] = base05

# Border used around UI elements in prompts.
theme["colors.prompts.border"] = base00

# Background color for prompts.
theme["colors.prompts.bg"] = base00

# Background color for the selected item in filename prompts.
theme["colors.prompts.selected.bg"] = base0A

# Foreground color of the statusbar.
theme["colors.statusbar.normal.fg"] = base0B

# Background color of the statusbar.
theme["colors.statusbar.normal.bg"] = base00

# Foreground color of the statusbar in insert mode.
theme["colors.statusbar.insert.fg"] = base00

# Background color of the statusbar in insert mode.
theme["colors.statusbar.insert.bg"] = base0D

# Foreground color of the statusbar in passthrough mode.
theme["colors.statusbar.passthrough.fg"] = base00

# Background color of the statusbar in passthrough mode.
theme["colors.statusbar.passthrough.bg"] = base0C

# Foreground color of the statusbar in private browsing mode.
theme["colors.statusbar.private.fg"] = base00

# Background color of the statusbar in private browsing mode.
theme["colors.statusbar.private.bg"] = base01

# Foreground color of the statusbar in command mode.
theme["colors.statusbar.command.fg"] = base05

# Background color of the statusbar in command mode.
theme["colors.statusbar.command.bg"] = base00

# Foreground color of the statusbar in private browsing + command mode.
theme["colors.statusbar.command.private.fg"] = base05

# Background color of the statusbar in private browsing + command mode.
theme["colors.statusbar.command.private.bg"] = base00

# Foreground color of the statusbar in caret mode.
theme["colors.statusbar.caret.fg"] = base00

# Background color of the statusbar in caret mode.
theme["colors.statusbar.caret.bg"] = base0E

# Foreground color of the statusbar in caret mode with a selection.
theme["colors.statusbar.caret.selection.fg"] = base00

# Background color of the statusbar in caret mode with a selection.
theme["colors.statusbar.caret.selection.bg"] = base0D

# Background color of the progress bar.
theme["colors.statusbar.progress.bg"] = base0D

# Default foreground color of the URL in the statusbar.
theme["colors.statusbar.url.fg"] = base05

# Foreground color of the URL in the statusbar on error.
theme["colors.statusbar.url.error.fg"] = base08

# Foreground color of the URL in the statusbar for hovered links.
theme["colors.statusbar.url.hover.fg"] = base05

# Foreground color of the URL in the statusbar on successful load
# (http).
theme["colors.statusbar.url.success.http.fg"] = base0C

# Foreground color of the URL in the statusbar on successful load
# (https).
theme["colors.statusbar.url.success.https.fg"] = base0B

# Foreground color of the URL in the statusbar when there's a warning.
theme["colors.statusbar.url.warn.fg"] = base0E

# Background color of the tab bar.
theme["colors.tabs.bar.bg"] = base00

# Color gradient start for the tab indicator.
theme["colors.tabs.indicator.start"] = base0D

# Color gradient end for the tab indicator.
theme["colors.tabs.indicator.stop"] = base0C

# Color for the tab indicator on errors.
theme["colors.tabs.indicator.error"] = base08

# Foreground color of unselected odd tabs.
theme["colors.tabs.odd.fg"] = base05

# Background color of unselected odd tabs.
theme["colors.tabs.odd.bg"] = base01

# Foreground color of unselected even tabs.
theme["colors.tabs.even.fg"] = base05

# Background color of unselected even tabs.
theme["colors.tabs.even.bg"] = base00

# Background color of pinned unselected even tabs.
theme["colors.tabs.pinned.even.bg"] = base0C

# Foreground color of pinned unselected even tabs.
theme["colors.tabs.pinned.even.fg"] = base07

# Background color of pinned unselected odd tabs.
theme["colors.tabs.pinned.odd.bg"] = base0B

# Foreground color of pinned unselected odd tabs.
theme["colors.tabs.pinned.odd.fg"] = base07

# Background color of pinned selected even tabs.
theme["colors.tabs.pinned.selected.even.bg"] = base05

# Foreground color of pinned selected even tabs.
theme["colors.tabs.pinned.selected.even.fg"] = base00

# Background color of pinned selected odd tabs.
theme["colors.tabs.pinned.selected.odd.bg"] = base05

# Foreground color of pinned selected odd tabs.
theme["colors.tabs.pinned.selected.odd.fg"] = base0E

# Foreground color of selected odd tabs.
theme["colors.tabs.selected.odd.fg"] = base00

# Background color of selected odd tabs.
theme["colors.tabs.selected.odd.bg"] = base05

# Foreground color of selected even tabs.
theme["colors.tabs.selected.even.fg"] = base00

# Background color of selected even tabs.
theme["colors.tabs.selected.even.bg"] = base05

# Background color for webpages if unset (or empty to use the theme's
# color).
# theme["colors.webpage.bg"] = base00
