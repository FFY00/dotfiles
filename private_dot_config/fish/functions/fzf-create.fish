function fzf-create --argument-names query --argument-names match --argument-names cmd_create --argument-names cmd_directory
	if test -z $cmd_create
		echo-color red 'error: cmd-create not provided' >&2
		echo "usage: $_ {q} {} <cmd-create> [cmd-directory]" >&2
		return 1
	end

	if test -z $match
		if not test -z $cmd_directory
			set -a actions "transform-query($cmd_directory {q})"
		end
		set -a actions "execute($cmd_create '$query')"
	end
	set -a actions accept-or-print-query

	string join + $actions
end
