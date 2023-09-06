function fish_user_key_bindings
	bind \cc 'commandline ""'
	bind \cr 'commandline (history | fzf)'
	bind \cs 'fish_commandline_prepend sudo'
end
