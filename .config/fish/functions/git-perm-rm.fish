function git-perm-rm
	command git filter-branch --force --index-filter \
		"git rm --cached --ignore-unmatch $argv" \
		--prune-empty --tag-name-filter cat -- --all
end
