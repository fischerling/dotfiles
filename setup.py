#!/usr/bin/env python3

"""Interactively install fischerlings dotfiles"""

import argparse
import os
import pwd
import sys
import subprocess

user = pwd.getpwuid(os.getuid())[0]
home_dir = os.getenv("HOME")
config_dir = os.getenv("XDG_CONFIG_HOME") or home_dir + "/.config"
cwd = os.getcwd()

def fish_config(quiet):
    """install and run fisherman"""
    # download fisherman
    import urllib.request

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
                print("fisherman already installed")
                return

    if not quiet:
        print("Installed fisherman -> execute fisher to pull plugins")

    subprocess.run(["fish", dir_path+"fisher.fish"])

def dotfile_loc_helper(quiet):
    """Create a symlink to get_dotfiles_location.sh into PATH"""

    if not os.path.exists(home_dir+"/.local/bin"):
        os.mkdir(home_dir+"/.local/bin")

    try:
        os.symlink(cwd + "/get_dotfiles_location.sh",
                home_dir + "/.local/bin/get_dotfiles_location")
    except Exception as e:
        if isinstance(e, FileExistsError):
            pass
        else:
            return e

mutt_target = [("muttrc", home_dir + "/.muttrc"),
               ("mutt", home_dir + "/.mutt")]

# targets are a list of tuples<file name, link destination> and/or functions
targets = {
        "lumail":
            [("config/lumail/lumail.lua", config_dir + "/lumail/lumail.lua")],
        "guixsd":
            [("guix/system.scm", "/etc/guix/system.scm"),
            ("guix/bashrc", home_dir + "/.bashrc")],
        "vim":
            [("vimrc", home_dir + "/.vimrc"),
            ("vim", home_dir + "/.vim")],
        "vis":
            [("config/vis", config_dir + "/vis")],
        "ssh":
            [("ssh/config.gpg", home_dir + "/.ssh/config")],
        "X":
            [("xinitrc", home_dir + "/.xinitrc"),
            ("xinitrc", home_dir + "/.xsession"),
            ("xprofile", home_dir + "/.xprofile"),
            dotfile_loc_helper,
            ("Xresources", home_dir + "/.Xresources")],
        "mutt": mutt_target,
        "neomutt": mutt_target,
        "zshrc":
            [("zshrc", home_dir + "/.zshrc")],
        "i3":
            [("config/i3", config_dir + "/i3"),
            dotfile_loc_helper],
        "sway":
            [("config/sway", config_dir + "/sway"),
            dotfile_loc_helper],
        "dir_colors":
            [("dir_colors", home_dir + "/.dir_colors")],
        "fish":
            [("config/fish/config.fish", config_dir + "/fish/config.fish"),
            ("config/fish/fishfile", config_dir + "/fish/fishfile"),
            dotfile_loc_helper,
            fish_config],
        "xonsh":
            [("config/xonsh/rc.xsh", config_dir + "/xonsh/rc.xsh")],
        "terminator":
            [("config/terminator/config", config_dir + "/terminator/config")],
        "termite":
            [("config/termite/dark", config_dir + "/termite/config"), # default colors
             ("config/termite/dark", config_dir + "/termite/dark"),
             ("config/termite/light", config_dir + "/termite/light")],
        "offlineimap":
            [("config/offlineimap", config_dir + "/offlineimap")],
        "mbsync":
            [("mbsync/mbsyncrc", home_dir + "/.mbsyncrc"),
             ("mbsync/mbsync.service", config_dir + "/systemd/user/mbsync.service"),
             ("mbsync/mbsync.timer", config_dir + "/systemd/user/mbsync.timer")],
        "msmtp":
            [("msmtprc", home_dir + "/.msmtprc")],
        "dunst":
            [("config/dunst/dunstrc", config_dir + "/dunst/dunstrc")],
        "mako":
            [("config/mako/config", config_dir + "/mako/config")],
        "qutebrowser":
            [("config/qutebrowser/config.py", config_dir + "/qutebrowser/config.py"),
             ("config/qutebrowser/dark.py", config_dir + "/qutebrowser/theme.py"), # default theme
             ("config/qutebrowser/dark.py", config_dir + "/qutebrowser/dark.py"),
             ("config/qutebrowser/light.py", config_dir + "/qutebrowser/light.py"),
             ("config/qutebrowser/autoconfig.yml", config_dir + "/qutebrowser/autoconfig.yml")],
        "FAU":
            [("FAU/wl-FAU-STUD.gpg", "/etc/netctl/wl-FAU-STUD"),
            ("FAU/fau_stud.conf.gpg", ""),
            ("FAU/start_fau_wlan.sh", home_dir + "/.local/bin/start_fau_wlan")],
        "mpd":
            [("mpdconf", home_dir + "/.mpdconf")]
        }

git_submodules_for = ["vim", "vis"]

def install_target(target, quiet):
    """Install a target"""

    if not quiet:
        print("Installing", target, "...")

    for instruction in targets[target]:
        if isinstance(instruction, tuple):
            if not os.path.exists(instruction[0]):
                print("Can't find", instruction[0],
                        ". Please make sure you are in the right directory.",
                        file=sys.stderr)
            else:
                # check if file is encrypted
                if instruction[0][-4:] == ".gpg":
                    if not os.path.isdir("decrypted"):
                        os.makedirs("decrypted")
                    start_filename = instruction[0].rfind("/") + 1
                    if subprocess.run([
                            "gpg",
                            "--output",
                            "decrypted/" + instruction[0][start_filename:-4],
                            "-d",
                            instruction[0]]):
                        # adjust instruction[0]
                        instruction = (
                                "decrypted/" + instruction[0][start_filename:-4],
                                instruction[1])

                        # set privacy friendly file permissions 
                        if not subprocess.run(["chmod", "600", instruction[0]]):
                            print("Skipping because changing permissions of",
                                    instruction[1], "failed. This could be a",
                                    "privacy risk!", file=sys.stderr)
                            continue
                    else:
                        print("Decrypting failed", file=sys.stderr)
                        continue

                    # only continue linking/installing if instruction[1] is not ""
                    if instruction[1] == "":
                        continue

                if not quiet:
                    print("Installing", instruction[0], "to", instruction[1])

                # make sure the target directory exists
                os.makedirs(os.path.dirname(instruction[1]), exist_ok=True)

                try:
                    os.symlink(cwd + "/" + instruction[0], instruction[1])
                except Exception as e:
                    if isinstance(e, PermissionError):
                        subprocess.run(["sudo", "ln", "-s",
                                cwd + '/' + instruction[0], instruction[1]])
                    elif isinstance(e, FileExistsError):
                        print("File already exists", file=sys.stderr)
                    else:
                        print(e, file=sys.stderr)

        elif callable(instruction):
            if not quiet:
                print("Running function", instruction)
            res = instruction(quiet)
            if res:
                print("The instruction", instruction, "of", target,
                        "failed with", str(res) + ".", file=sys.stderr)
                print("This can leaf your installation in a broken state",
                        file=sys.stderr)
        else:
            print("I don't understand", instruction,
                    "\nThe instruction musst be a tuple or a function.",
                    "\nSKIPPING IT", file=sys.stderr)

    if target in git_submodules_for:
        choice = input(target + " uses git submodules want to pull them ? (Y/n) ")
        if choice in ["Y", "y", ""]:
            subprocess.run(["git", "submodule", "update", "--init"])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-q", "--quiet", action="store_true")
    parser.add_argument("targets", type=str, nargs='*')

    args = parser.parse_args()

    if args.targets:
        for t in args.targets:
            install_target(t, args.quiet)
    else:
        if not args.quiet:
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
                install_target(target, args.quiet)
        else:
            for n in choice.strip().split(" "):
                install_target(targets_ord[int(n)], args.quiet)

        if not args.quiet:
            print("Good Bye. Have fun with your new configuration")


if __name__ == "__main__":
    main()
