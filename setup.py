"""Interactively install fischerlings dotfiles"""

import os
import sys

home_dir = os.getenv("HOME")

targets = {"vimrc": ("vimrc", home_dir + "/.vimrc"),
        "vim.d": ("vim", home_dir + "/.vim"),
        "ssh-config": ("ssh/config", home_dir + "/.ssh/config"),
        "xinitrc": ("xinitrc", home_dir + "/.xinitrc"),
        "Xresources": ("Xresources", home_dir + "/.Xresources"),
        "muttrc": ("muttrc", home_dir + "/.muttrc"),
        "zshrc": ("zshrc", home_dir + "/zshrc"),
        "i3-config": ("i3", home_dir + "/.i3"),
        "dir_colors": ("dir_colors", home_dir + "/.dir_colors"),
        "fish-config": ("config/fish/config.fish", home_dir + "/.config/fish/config.fish"),
        "terminator-config": ("config/terminator/config", home_dir + "/.config/terminator/config")}

git_submodules_for = ["vim.d", "fish-config"]

def install_target(target, quiet):
    """Install a target"""

    target_files = targets[target]
    if not quiet:
        print("Installing", target, "to", target_files[1])
    if os.path.exists(target_files[0]):
        try:
            os.symlink(target_files[0], target_files[1])
        except FileExistsError as e:
            print(e)
    else:
        print("Can't find", target_files[0]+". Please make sure you are in the right directory.")

    if target in git_submodules_for:
        choice = input(target + "uses git submodules want to pull them ? (Y/n)")
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

