function c2p --description 'Copy clipboard to primary selection'
	xclip -o -selection clipboard | xclip -i -selection primary
end
