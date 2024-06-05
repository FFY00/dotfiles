function has-unstaged-files --wraps='git diff --quiet'
	command git diff --quiet $argv
	if test $status -eq 0
		return 1
	else
		return 0
	end
end
