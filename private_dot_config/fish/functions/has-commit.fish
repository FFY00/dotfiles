function has-commit --argument commit
	if test -z $commit
		echo-color red "usage: $_ <commit> [num]" >&2
		return 1
	end
	command git rev-parse $commit &>/dev/null
	return $status
end
