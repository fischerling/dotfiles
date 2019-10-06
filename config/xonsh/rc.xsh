### ALIASES ###
aliases["ll"] = "ls -l -h"
aliases["la"] = "ll -a"

# git
aliases["ga"] = "git add"
aliases["gca"] = "git commit -v -a"
aliases["gcm"] = "git commit -m"
aliases["gl"] = "git pull"
aliases["glg"] = "git log --stat --color"
aliases["gp"] = "git push"
aliases["gst"] = "git status"

def pss(args, stdin=None, stdout=None, stderr=None):
    if len(args) != 1:
        print("Usage: pss PATTERN", file=stderr)
    pids = $(pgrep -d , -f @(args[0]))[:-1]
    if pids:
        $[ps -Fp @(pids)]
aliases["pss"] = pss

def fd(args, stdin=None, stdout=None, stderr=None):
    if len(args) != 1:
        print("Usage: fd name", file=stderr)
    $[find -name @(f"*{args[0]}*")]
aliases["fd"] = fd

def upto(args, stdin=None, stdout=None, stderr=None):
    import os.path as path
    if len(args) != 1:
        print("Usage: upto PATTERN", file=stderr)
    dirs = $PWD.split(path.sep)
    for i, d in enumerate(dirs):
        if args[0] in d:
            ![cd @("/".join(dirs[:i+1]))]
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
