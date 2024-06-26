function has-commit --argument commit
	if test -z $commit
		echo-color red 'Usage: commit-parent <commit> [num]' >&2
		return 1
	end
	command git rev-parse $commit &>/dev/null
	return $status
end
