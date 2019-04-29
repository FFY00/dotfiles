# Defined in /tmp/fish.hIgUbC/ga.fish @ line 2
function ga
	git ls-files -m -o --exclude-standard | fzf -m | xargs -r git add
end
