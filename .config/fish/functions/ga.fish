# Defined in /tmp/fish.hr7tHJ/ga.fish @ line 2
function ga
	git ls-files -m -o --exclude-standard (git rev-parse --show-toplevel) | fzf -m | xargs -r git add
end
