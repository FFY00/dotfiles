function commit-msg --argument commit
	command git show -s --format='%s' $commit
end
