function eval-shell-vars
	argparse U/universal s/shell= -- $argv

	# If no value was provided as an argument, read from stdin
	if test -z "$argv"
		read argv
	end

	if test -z "$_flag_shell"
		set _flag_shell 'bash'
	end

	# Default shell config
	set shell_command $_flag_shell -c
	set shell_print_vars 'env'
	# Custom shell config
	switch $_flag_shell
		case sh bash
			# Set allexport so that all variables are exported
			set shell_before 'set -o allexport'
		case csh
		case '*'
			echo-color red "Unsupported shell '$_flag_shell' (supported: sh, bash, csh)"
	end

	set shell_script "$(string join -n \n "$shell_before" $argv "$shell_after" "$shell_print_vars")"
	for var in (env -i $shell_command "$shell_script")
		# Ignore errors as we might be trying to set a read-only variable
		set -gx $_flag_universal (string split '=' $var) 2>/dev/null
	end
	# Return 0 explicitely, as $status from the set command might be non-zero
	return 0

end
