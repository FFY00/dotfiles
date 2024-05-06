function has-unstaged-files --wraps='git diff --quiet'
	if git diff --quiet $argv
		return 1
	else
		return 0
	end
end
