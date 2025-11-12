function gl --wrap 'git log'
	command git log --pretty=oneline --color=always $argv | less -r
end
