# Defined in /tmp/fish.TnU7Um/ga.fish @ line 2
function ga
	git add (git ls-files -m -o --exclude-standard (git rev-parse --show-toplevel) | sort -u | fzf -m)
end
