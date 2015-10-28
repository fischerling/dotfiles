.PHONY: all vim_t i3_t xinitrc_t terminator_t fish_t zsh_t ssh_t Xresources_t

all: vim_t i3_t xinitrc_t terminator_t fish_t zsh_t
	git submodule init
	git submodule update

vim_t: ./vim ./vimrc
	ln -s $(PWD)/vim ~/.vim
	ln -s $(PWD)/vimrc ~/.vimrc

i3_t: ./i3
	ln -s $(PWD)/i3 ~/.i3

xinitrc_t: ./xinitrc
	ln -s $(PWD)/xinitrc ~/.xinitrc

terminator_t: config/terminator/config
	mkdir -p ~/.config/terminator/
	ln -s $(PWD)/config/terminator/config ~/.config/terminator/config

fish_t: config/fish
	mkdir -p ~/.config/fish
	ln -s $(PWD)/config/fish/config.fish ~/.config/fish/config.fish
	ln -s $(PWD)/config/fish/functions ~/.config/fish/functions

zsh_t: zshrc
	ln -s $(PWD)/zshrc ~/.zshrc

ssh_t: ssh/config
	mkdir -p ~/.ssh
	ln -s $(PWD)/ssh/config ~/.ssh/config

Xresources_t: Xresources
	ln -s $(PWD)/Xresources ~/.Xresources
