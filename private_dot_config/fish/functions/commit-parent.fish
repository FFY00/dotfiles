function commit-parent --argument commit num
	if test -z $commit
		set commit HEAD
	end
	if test -z $num
		set num 1
	end

	set parent (command git rev-parse "$commit~$num" 2>/dev/null)
	set rev_parse_status $status
	if test $rev_parse_status -eq 0
		echo $parent
		return 0
	end

	# If the git rev-parse failed and the original commit exists, it means it has no parent, so we are at the root.
	if has-commit $commit
		echo -- --root
		return 0
	end

	return $rev_parse_status
end
