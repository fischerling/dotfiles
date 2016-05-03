"""Interactively install fischerlings dotfiles"""

import os
import sys

home_dir = os.getenv("HOME")
cwd = os.getcwd()

def fish_config(quiet):
    """install and run fisherman"""
    # download fisherman
    import urllib.request
    import subprocess

    if not quiet:
        print("Installing fisherman, see: https://github.com/fisherman/fisherman")
    with urllib.request.urlopen("https://git.io/fisherman") as f:
        fisher = f.read().decode("utf-8")

    dir_path = home_dir+"/.config/fish/functions/"
    # install fisherman at $fish_config/functions/
    if not os.path.exists(dir_path):
        os.mkdir(dir_path)
    else:
        if not os.path.exists(dir_path+"fisher.fish"):
            file = open(dir_path+"fisher.fish", 'w')
            file.write(fisher)
        else:
            if not quiet:
                print("fisherman all ready installed")
                return

    if not quiet:
        print("Installed fisherman -> execute fisher to pull plugins")

    subprocess.run(["fish", dir_path+"fisher.fish"])

# targets are a list of tuples<file name, link destination> and/or functions

targets = {"vimrc": [("vimrc", home_dir + "/.vimrc")],
        "vim.d": [("vim", home_dir + "/.vim")],
        "ssh-config": [("ssh/config", home_dir + "/.ssh/config")],
        "xinitrc": [("xinitrc", home_dir + "/.xinitrc")],
        "Xresources": [("Xresources", home_dir + "/.Xresources")],
        "mutt": [("muttrc", home_dir + "/.muttrc"), ("mutt", home_dir + "/.mutt")],
        "zshrc": [("zshrc", home_dir + "/zshrc")],
        "i3-config": [("i3", home_dir + "/.i3")],
        "dir_colors": [("dir_colors", home_dir + "/.dir_colors")],
        "fish-config": [("config/fish/config.fish", home_dir + "/.config/fish/config.fish"),
            ("config/fish/fishfile", home_dir + "/.config/fish/fishfile"), fish_config],
        "terminator-config": [("config/terminator/config", home_dir + "/.config/terminator/config")]}

git_submodules_for = ["vim.d"]

def install_target(target, quiet):
    """Install a target"""

    if not quiet:
        print("Installing", target, "...")

    for instruction in targets[target]:
        if isinstance(instruction, tuple):
            if not quiet:
                print("Installing", instruction[0], "to", instruction[1])
            if os.path.exists(instruction[0]):
                try:
                    os.symlink(cwd + "/" + instruction[0], instruction[1])
                except FileExistsError as e:
                    print(e, file=sys.stderr)
            else:
                print("Can't find", instruction[0] +
                        ". Please make sure you are in the right directory.", file=sys.stderr)
        elif callable(instruction):
            if not quiet:
                print("Running function", instruction)
            res = instruction(quiet)
            if res:
                if not quiet:
                    print("The instruction", instruction, "of", target, "failed with", str(res) + ".")
                    print("This can leaf your installation in a broken state")
                    print("ABORTING to prevent failures.")
                exit(res)
        else:
            print("I don't understand", instruction,
                    "\nThe instruction musst be a tuple or a function.\nSKIPPING IT")

    if target in git_submodules_for:
        choice = input(target + " uses git submodules want to pull them ? (Y/n) ")
        if choice in ["Y", "y", ""]:
            import subprocess
            subprocess.run(["git", "submodule", "update", "--init"])


def main():

    quiet = False
    if "-q" in sys.argv:
        quiet = True
        del(sys.argv[sys.argv.index("-q")])

    if len(sys.argv) > 1:
        for arg in sys.argv[1:]:
            if arg in targets:
                install_target(arg, quiet)
    else:
        if not quiet:
            print("Welcome to the installation script of fischerlings dotfiles.")
            print("Located at: https://github.com/fischerling/dotfiles")
            print()

        targets_ord = [x for x in targets]
        for i, target in zip(range(len(targets_ord)), targets_ord):
            print(str(i)+":", target)
        print("Enter n° of configurations to be installed or all")
        choice = input("==> ")
        
        if choice == "":
            pass
        elif "all" in choice:
            for target in targets:
                install_target(target, quiet)
        else:
            for n in choice.strip().split(" "):
                install_target(targets_ord[int(n)], quiet)

        if not quiet:
            print("Good Bye. Have fun with your new configuration")


if __name__ == "__main__":
    main()

