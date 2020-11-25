# If not running interactively, don't do anything
[[ $- != *i* ]] && return

pathadd() {
	if [ -d "$1" ] && [[ "$PATH" != *"$1"* ]]; then
		PATH="$1":$PATH
	fi
}

pathadd /bin
pathadd /sbin
pathadd ${HOME}/.local/bin

if [[ -z "$DOTFILES_LOCATION" ]]
then
	DOTFILES_LOCATION=$(dirname $(readlink -f $HOME/.bashrc))
	export DOTFILES_LOCATION
fi

pathadd ${DOTFILES_LOCATION}/bin

source $DOTFILES_LOCATION/aliases

#exec xonsh

