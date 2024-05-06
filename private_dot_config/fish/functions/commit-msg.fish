function commit-msg --argument commit
	command git show -s --format='%s' $commit 2>/dev/null
	return $status
end
