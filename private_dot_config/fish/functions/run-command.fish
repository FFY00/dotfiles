function run-command
	echo-color dim "\$ $argv"
	command $argv
	return $status
end
