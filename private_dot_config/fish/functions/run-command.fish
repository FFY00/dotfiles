function run-command
	# Print and execute command.
	# In case there are paths in the arguments, try un-expanding ~.
	echo-color dim "\$ $(string escape -- $argv | string replace $HOME '~' | string join ' ')"
	$argv
	return $status
end
