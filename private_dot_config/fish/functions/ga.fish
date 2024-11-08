function ga
	set file '"$(echo {} | sed "s/^.. //")"'  # Use this instead of the placeholder, as we need to remove the git status prefix
	set is_tracked_cmd "git ls-files --error-unmatch $file >&2 2>/dev/null"
	set git_diff_cmd "git diff --no-ext-diff --color=always -- $file | sed 1,4d"
	set cat_cmd "bat --color=always --plain $file"

	set git_args -c color.status=always
	set fzf_args --preview="$is_tracked_cmd && $git_diff_cmd || $cat_cmd"
	# See https://en.wikipedia.org/wiki/ANSI_escape_code#Description
	# Control sequence format: ESC [ (parameter bytes - 0x30-0x3F)* (final byte - 0x40-0x7F)
	# \\x1b - match ESC
	# [0-9:-?] - match 0x30 to 0x3F
	# [@-~A-Za-z] - match 0x40 to 0x7F
	set ctrseq '\(\\x1b\[[0-9:-?]*[@-~A-Za-z]\)'
	set files (git ls-files -m -o --exclude-standard (git rev-parse --show-toplevel))
	set files_to_add (
		git $git_args status -s $files 2>/dev/null \
		| sed -e "/^$ctrseq*\S$ctrseq*\s/d" -e 's/"//' -e 's/"$//' \
		| fzf -m --ansi $fzf_args \
		| sed -e 's/^\s//' -e 's/\s+/ /g' -e 's/^.*.* //'
	)
	if test $status -eq 0; and string length -q "$files_to_add"
		run-command git add $files_to_add
	end
end
