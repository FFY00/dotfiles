function nvim-profile
	argparse --max-args 1 'h/help' 'o/output=?' -- $argv

	# Help message
	if test $status -ne 0 -o -n "$_flag_help"
		echo "usage: $_ [-h] [--output <profile.log>] <file-to-open>"
		return $status
	end

	# Defaults
	if test -z "$_flag_output"
		set _flag_output profile.log
	end
	set file "$argv[1]"

	# Info message
	if test -n "$file"
		set -a info_msg "Opening '$argv[1]'."
	else
		set -a info_msg 'Not opening any file.'
	end
	set -a info_msg "Saving profiler output to '$_flag_output'."
	echo-color yellow (string join ' ' $info_msg)

	# Run command
	set -a commands \
		"profile start $_flag_output" \
		'profile func *' \
		'profile file *'
	test -n "$argv[1]" && set -a commands "edit $argv[1]"
	set -a commands quit
	run-command nvim -c (string join ' | ' $commands)
end
