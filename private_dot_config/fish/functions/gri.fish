function gri --wraps='git rebase -i --autosquash'
	set args rebase -i --autosquash

	# Only consider the last X commits when searching for the first fixup commit.
	# This avoids messing with older commits already present in the history.
	set max_search_commits 30

	# If no argument is provided, rebase on the parent of the target of the first fixup commit.
	if test -z "$argv"
		set fixups (git rev-list --grep=^fixup! HEAD~$max_search_commits...HEAD)
		if test -z "$fixups"
			echo-color red "Didn't find a fixup commit in the last $max_search_commits commits. Please set the rebase target manually." >&2
			return 1
		end

		# Find the earliest fixup target.
		set fixup_target_commit_num (commit-num HEAD)
		for commit in $fixups
			set target (commit-from-msg (commit-msg $commit | sed 's/^fixup! //'))
			set target_commit_num (commit-num $target)
			if test $target_commit_num -lt $fixup_target_commit_num
				set fixup_target_commit_num $target_commit_num
				set fixup_target $target
			end
		end

		set fixup_target_parent (commit-parent $fixup_target)
		echo-color blue "Rebasing on the parent of the first fixup: $(commit-summary $fixup_target_parent)"
		set argv "$fixup_target_parent"
	end

	if not has-unstaged-files; or not bool-prompt 'You have unstaged files, do you want to stash them?'
		run-command git $args $argv
	else
		# Stash unstaged files.
		run-command git stash --quiet
		and run-command git $args $argv
		and run-command git stash pop --quiet
	end
	return $status
end
