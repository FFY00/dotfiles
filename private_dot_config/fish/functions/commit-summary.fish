function commit-summary --argument commit
	if test $commit = --root
		echo '--root (commit log root)'
		return 0
	end

	set -l message (commit-msg $commit)
	if test $status -eq 0
		echo "$commit ($message)"
		return 0
	end
	return 1
end
