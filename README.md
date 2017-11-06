# my dotfiles
---

## Installation

For some scripts/snippets you don't know where they will be executed.
Whenever a absolute path into the dotfile directory is needed the environment
variable `DOTFILES_LOCATION` is used.

The variable is exported in zshrc or config.fish or xinitrc.
If you don't set it that way, please remember to export `DOTFILES_LOCATION`
somewhere else.

Good places are:

+ shell configs
+ at session start


### Easy Installation

If you just want to install all my dotfiles without customization run:
```sh
git clone https://github.com/fischerling/dotfiles ~/.dotfiles
cd ~/.dotfiles
./setup.py
```
