function gri --wraps='git rebase -i --autosquash'
	set args rebase -i --autosquash

	# Only consider the last X commits when searching for the first fixup commit.
	# This avoids messing with older commits already present in the history.
	set max_search_commits 30

	# If no argument is provided, rebase on the parent of the target of the first fixup commit.
	if test -z "$argv"
		set first_fixup (git rev-list --grep=^fixup! --reverse --max-count $max_search_commits HEAD | head -n1)
		if test -z "$first_fixup"
			echo-color red "Didn't find a fixup commit in the last $max_commits commits. Please set the rebase target manually." >&2
			return 1
		end
		set fixup_target (commit-from-msg (commit-msg $first_fixup | sed 's/^fixup! //'))
		set fixup_target_parent (git rev-parse "$fixup_target~1")
		echo-color dim "Rebasing on the parent of the first fixup: $fixup_target_parent ($(commit-msg $fixup_target_parent))"
		set argv "$fixup_target_parent"
	end

	if has-unstaged-files; and bool-prompt 'You have unstaged changes, do you want to stash them?'
		# Stash unstaged files.
		run-command git stash --quiet
		run-command git $args $argv
		run-command git stash pop --quiet
	else
		command git $args $argv
	end
end
