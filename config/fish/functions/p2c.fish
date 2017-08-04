function p2c --description 'Copy primary selection to clipboard'
	xclip -o -selection primary | xclip -i -selection clipboard
end
