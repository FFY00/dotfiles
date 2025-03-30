# Defined in /tmp/fish.dkUCBe/gm.fish @ line 2
function gm --wraps 'git commit'
	for arg in $argv
		# If it isn't an option (starts with -), add -m/--message.
		if not string match -- '-*' "$arg"
			set -a options -m
		end
		set -a options "$arg"
	end
	command git commit $options
end
