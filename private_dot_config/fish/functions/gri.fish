function gri --wraps 'git rebase -i --autosquash'
	command git rebase -i --autosquash $argv
end
