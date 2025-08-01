#!/usr/bin/env python3
"""Interactively install fischerling's dotfiles"""

import argparse
import os
import pwd
import sys
import subprocess

user = pwd.getpwuid(os.getuid())[0]
home_dir = os.getenv("HOME")
config_dir = os.getenv("XDG_CONFIG_HOME") or home_dir + "/.config"
local_bin_dir = home_dir + "/.local/bin"
cwd = os.getcwd()


def fish_config(quiet):
    """install and run fisher"""
    # download fisher
    import urllib.request

    if not quiet:
        print("Installing fisher, see: https://github.com/jorgebucaran/fisher")
    with urllib.request.urlopen("https://git.io/fisher") as f:
        fisher = f.read().decode("utf-8")

    dir_path = home_dir + "/.config/fish/functions/"
    # install fisher at $fish_config/functions/
    if not os.path.exists(dir_path):
        os.mkdir(dir_path)
    else:
        if not os.path.exists(dir_path + "fisher.fish"):
            file = open(dir_path + "fisher.fish", 'w')
            file.write(fisher)
        else:
            if not quiet:
                print("fisher already installed")
                return

    if not quiet:
        print("Installed fisher -> execute fisher to pull plugins")

    subprocess.run(["fish", dir_path + "fisher.fish"])


def vdirsyncer_init(quiet):
    """discover and sync"""
    if not quiet:
        print("Running vdirscyner discover")

    subprocess.run("yes | vdirsyncer discover", shell=True, check=True)

    if not quiet:
        print("Running vdirscyner sync")
    subprocess.run("vdirsyncer sync", shell=True, check=True)


def dotfile_loc_helper(quiet):
    """Create a symlink to get_dotfiles_location.sh into PATH"""

    if not os.path.exists(local_bin_dir):
        os.mkdir(local_bin_dir)

    try:
        os.symlink(cwd + "/get_dotfiles_location.sh",
                   local_bin_dir + "/get_dotfiles_location")
    except Exception as e:
        if isinstance(e, FileExistsError):
            pass
        else:
            return e


mutt_target = [("muttrc", home_dir + "/.muttrc"),
               ("mutt", home_dir + "/.mutt")]

# yapf: disable
# targets are a list of tuples<file name, link destination> and/or functions
targets = {
        "dir_colors":
            [("dir_colors", home_dir + "/.dir_colors")],
        "dunst":
            [("config/dunst/dunstrc", config_dir + "/dunst/dunstrc")],
        "FAU":
            [("FAU/wl-FAU-STUD.gpg", "/etc/netctl/wl-FAU-STUD"),
            ("FAU/fau_stud.conf.gpg", ""),
            ("FAU/start_fau_wlan.sh", local_bin_dir + "/start_fau_wlan")],
        "fish":
            [("config/fish/config.fish", config_dir + "/fish/config.fish"),
            ("config/fish/fish_add_path_fallback.fish",
             config_dir + "/fish/functions/fish_add_path_fallback.fish"),
            ("config/fish/fish_plugins", config_dir + "/fish/fish_plugins"),
            dotfile_loc_helper,
            fish_config],
        "gdb":
            [("gdbinit", home_dir + "/.gdbinit")],
        "gpg":
            [("gnupg/gpg-agent.conf", home_dir + "/.gnupg/gpg-agent.conf")],
        "guixsd":
            [("guix/system.scm", "/etc/guix/system.scm"),
            ("guix/bashrc", home_dir + "/.bashrc")],
        "i3":
            [dotfile_loc_helper],
        "lumail":
            [("config/lumail/lumail.lua", config_dir + "/lumail/lumail.lua")],
        "mako":
            [("config/mako/config", config_dir + "/mako/config")],
        "mbsync":
            [("mbsync/mbsyncrc.gpg", home_dir + "/.mbsyncrc"),
             ("mbsync/mbsync.service", config_dir + "/systemd/user/mbsync.service"),
             ("mbsync/mbsync.timer", config_dir + "/systemd/user/mbsync.timer")],
        "mpd":
            [("mpdconf", home_dir + "/.mpdconf")],
        "mpv":
            [("config/mpv/config", config_dir + "/mpv/config")],
        "msmtp":
            [("msmtprc.gpg", home_dir + "/.msmtprc")],
        "mutt": mutt_target,
        "neomutt": mutt_target,
        "notmuch":
            [("config/notmuch", config_dir + "/notmuch")],
        "qutebrowser":
            [("config/qutebrowser/config.py", config_dir + "/qutebrowser/config.py"),
             ("config/qutebrowser/dark.py", config_dir + "/qutebrowser/theme.py"), # default theme
             ("config/qutebrowser/dark.py", config_dir + "/qutebrowser/dark.py"),
             ("config/qutebrowser/light.py", config_dir + "/qutebrowser/light.py"),
             ("config/qutebrowser/autoconfig.yml", config_dir + "/qutebrowser/autoconfig.yml")],
        "scripts":
            [("bin/alert", local_bin_dir + "/alert"),
             ("bin/set_theme", local_bin_dir + "/set_theme")],
        "ssh":
            [("ssh/config.gpg", home_dir + "/.ssh/config"),
             ("ssh/ssh-agent.service", config_dir + "/systemd/user/ssh-agent.service")],
        "sway":
            [dotfile_loc_helper],
        "terminator":
            [("config/terminator/config", config_dir + "/terminator/config")],
        "termite":
            [("config/termite/dark", config_dir + "/termite/config"), # default colors
             ("config/termite/dark", config_dir + "/termite/dark"),
             ("config/termite/light", config_dir + "/termite/light")],
        "vdirsyncer":
            [("config/vdirsyncer/config.gpg", config_dir + "/vdirsyncer/config"),
             vdirsyncer_init],
        "vim":
            [("vimrc", home_dir + "/.vimrc"),
            ("vim", home_dir + "/.vim")],
        "vis":
            [("config/vis", config_dir + "/vis")],
        "X":
            [("xinitrc", home_dir + "/.xinitrc"),
            ("xinitrc", home_dir + "/.xsession"),
            ("xprofile", home_dir + "/.xprofile"),
            dotfile_loc_helper,
            ("Xresources", home_dir + "/.Xresources")],
        "xdg":
            [("mimeapps.list", config_dir + "/mimeapps.list")],
        "xonsh":
            [("config/xonsh/rc.xsh", config_dir + "/xonsh/rc.xsh")],
        "zshrc":
            [("zshrc", home_dir + "/.zshrc")],
        }
# yapf: enable


def gen_simple_config_target(target_name: str) -> tuple[str, str]:
    """Generate the target definition for linking the config/<target> to <config_dir>/<target>"""
    return (f'config/{target_name}', f'{config_dir}/{target_name}')


# All simple targets to generate
simple_config_targets = [
    "sway", "i3", "vis", "gdb", "khard", "khal", "offlineimap", "wofi",
    "firejail", "alacritty"
]

# Generate all simple targets
for simple_config_target in simple_config_targets:
    present_targets = targets.get(simple_config_target, [])
    present_targets.append(gen_simple_config_target(simple_config_target))

git_submodules_for = ["vim", "vis"]


def install_target(target, quiet):
    """Install a target"""

    if not quiet:
        print("Installing", target, "...")

    for instruction in targets[target]:
        if isinstance(instruction, tuple):
            if not os.path.exists(instruction[0]):
                print("Can't find",
                      instruction[0],
                      ". Please make sure you are in the right directory.",
                      file=sys.stderr)
            else:
                # check if file is encrypted
                if instruction[0][-4:] == ".gpg":
                    if not os.path.isdir("decrypted"):
                        os.makedirs("decrypted")
                    start_filename = instruction[0].rfind("/") + 1
                    filename = f'{target}-{instruction[0][start_filename:-4]}'
                    if subprocess.run([
                            "gpg", "--output", "decrypted/" + filename, "-d",
                            instruction[0]
                    ]):
                        # adjust instruction[0]
                        instruction = ("decrypted/" + filename, instruction[1])

                        # set privacy friendly file permissions
                        if not subprocess.run(["chmod", "600", instruction[0]
                                               ]):
                            print("Skipping because changing permissions of",
                                  instruction[1],
                                  "failed. This could be a",
                                  "privacy risk!",
                                  file=sys.stderr)
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
                        subprocess.run([
                            "sudo", "ln", "-s", cwd + '/' + instruction[0],
                            instruction[1]
                        ])
                    elif isinstance(e, FileExistsError):
                        print("File already exists", file=sys.stderr)
                    else:
                        print(e, file=sys.stderr)

        elif callable(instruction):
            if not quiet:
                print("Running function", instruction)
            res = instruction(quiet)
            if res:
                print("The instruction",
                      instruction,
                      "of",
                      target,
                      "failed with",
                      str(res) + ".",
                      file=sys.stderr)
                print("This can leaf your installation in a broken state",
                      file=sys.stderr)
        else:
            print("I don't understand",
                  instruction,
                  "\nThe instruction musst be a tuple or a function.",
                  "\nSKIPPING IT",
                  file=sys.stderr)

    if target in git_submodules_for:
        choice = input(target +
                       " uses git submodules want to pull them ? (Y/n) ")
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
            print(
                "Welcome to the installation script of fischerlings dotfiles.")
            print("Located at: https://github.com/fischerling/dotfiles")
            print()

        targets_ord = [x for x in targets]
        for i, target in zip(range(len(targets_ord)), targets_ord):
            print(str(i) + ":", target)
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
