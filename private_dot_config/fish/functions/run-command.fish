function run-command
	# Build a shell-escaped version of the command
	for arg in $argv
		switch "$arg"
			case '* *'
				set -a repr "'$arg'"
			case '*'
				set -a repr "$arg"
		end
	end
	# Print and execute command
	echo-color dim "\$ $repr"
	command $argv
	return $status
end
