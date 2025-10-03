function string-join-readable
	set -l separator ', '
	set -l last_separator ', and '
	set -l prefix ''
	set -l suffix ''

	argparse h/help s/separator= l/last-separator= prefix= suffix= -- $argv

	if set -ql _flag_h
		echo "usage: $_ [OPTION]... [ITEM]..."
		echo
		echo "  -s, --separator=SEP        separator used for all but the last item (defaults to '$separator')"
		echo "  -l, --last-separator=SEP   separator used for the last item (if -s/--separator is specified, defaults to its value, otherwise '$last_separator')"
		echo "      --prefix=VALUE         prepend value to each item"
		echo "      --suffix=VALUE         append value to each item"
		echo
		echo "If no ITEMs are provided, read standard input."
		return 1
	end >&2

	set -ql _flag_s; and set separator $_flag_s; and set last_separator $_flag_s
	set -ql _flag_l; and set last_separator $_flag_l
	set -ql _flag_prefix; and set prefix "$_flag_prefix"
	set -ql _flag_suffix; and set suffix "$_flag_suffix"

	test (count $argv) -gt 0
	and set -l items $argv
	or read --prompt-str '' -la items

	switch (count $items)
		case 0
		case 1
			printf '%s%s%s\n' $prefix $items[1] $suffix
		case '*'
			printf '%s%s%s' $prefix $items[1] $suffix
			for item in $items[2..-2]
				printf '%s%s%s%s' $separator $prefix $item $suffix
			end
			printf '%s%s%s%s\n' $last_separator $prefix $items[-1] $suffix
	end
end
