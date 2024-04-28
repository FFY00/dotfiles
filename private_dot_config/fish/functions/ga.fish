function ga
	set -l git_args -c color.status=always
	set -l fzf_args --preview='git diff --no-ext-diff --color=always -- {-1} | sed 1,4d; bat --color=always --plain {-1}'
	# See https://en.wikipedia.org/wiki/ANSI_escape_code#Description
	# Control sequence format: ESC [ (parameter bytes - 0x30-0x3F)* (final byte - 0x40-0x7F)
	# \\x1b - match ESC
	# [0-9:-?] - match 0x30 to 0x3F
	# [@-~A-Za-z] - match 0x40 to 0x7F
	set -l ctrseq '\(\\x1b\[[0-9:-?]*[@-~A-Za-z]\)'
	set -l files (git ls-files -m -o --exclude-standard (git rev-parse --show-toplevel))
	set -l files_to_add (
		git $git_args status -s $files 2>/dev/null \
		| sed "/^$ctrseq*\S$ctrseq*\s/d" \
		| fzf -m --ansi $fzf_args \
		| sed -e 's/^\s//' -e 's/\s+/ /g' \
		| cut -d' ' -f2
	)
	if test $status -eq 0; and string length -q "$files_to_add"
		echo git add "$files_to_add"
		git add $files_to_add
	end
end
