function gpo --wraps='git push --set-upstream origin'
	command git push --set-upstream origin $argv
end
