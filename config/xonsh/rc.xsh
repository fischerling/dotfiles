### ALIASES ###

# import shell aliases
import re
alias_file = p'$DOTFILES_LOCATION/aliases'
with alias_file.open('r') as af:
    common_aliases = af.read()

for line in common_aliases.splitlines():
    if line.startswith('alias '):
        match = re.match(r'^alias ([\w-]*)=[\'\"](.*?)[\"\']$', line)
        if match:
            aliases[match.group(1)] = match.group(2)

def fd(args, stdin=None, stdout=None, stderr=None):
    if len(args) != 1:
        print("Usage: fd name", file=stderr)
    find -name @(f"*{args[0]}*")
aliases["fd"] = fd

def upto(args, stdin=None, stdout=None, stderr=None):
    import os.path as path
    if len(args) != 1:
        print("Usage: upto PATTERN", file=stderr)
    dirs = $PWD.split(path.sep)
    for i, d in enumerate(dirs):
        if args[0] in d:
            cd @("/".join(dirs[:i+1]))
            break
aliases["upto"] = upto

### STYLE ###
$XONSH_COLOR_STYLE = 'native'

$PL_PROMPT = "cwd>branch"
$PL_RPROMPT = "rtns>timing"
$PL_TOOLBAR = "!"

xontrib load powerline2
$PL_COLORS["branch"] = "WHITE"

### BEHAVIOUR ###
$COMPLETIONS_CONFIRM = True
$XONSH_HISTORY_MATCH_ANYWHERE = True
$XONSH_SHOW_TRACEBACK = True

# make modules in CWD importable
import sys
sys.path.append('')
