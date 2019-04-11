function ga
	git add (git ls-tree -r --name-only HEAD | fzf -m)
end
