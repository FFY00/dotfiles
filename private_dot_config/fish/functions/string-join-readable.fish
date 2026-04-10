function string-join-readable
	argparse h/help s/separator= l/last-separator= style= separator-style= prefix= suffix= -- $argv

	if arg-set separator ', '
		arg-set last_separator $separator
	else
		arg-set last_separator ', and '
	end
	arg-set style normal
	arg-set separator_style normal
	arg-set prefix
	arg-set suffix

	if set -ql _flag_h
		echo "usage: $_ [OPTION]... [ITEM]..."
		echo
		echo "  -s, --separator=SEP        separator used for all but the last item (defaults to '$_flag_separator_default')"
		echo "  -l, --last-separator=SEP   separator used for the last item (if -s/--separator is specified, defaults to its value, otherwise '$_flag_last_separator_default')"
		echo "      --style=NAME           style string to be applied to the item (as in echo-color)"
		echo "      --separator-style=NAME style string to be applied to the item (as in echo-color)"
		echo "      --prefix=VALUE         prepend value to each item"
		echo "      --suffix=VALUE         append value to each item"
		echo
		echo "If no ITEMs are provided, read standard input."
		return 1
	end >&2

	test (count $argv) -gt 0
	and set -l items $argv
	or read --prompt-str '' -la items

	switch (count $items)
		case 0
		case 1
			echo-color $style -s $prefix $items[1] $suffix
		case '*'
			echo-color $style -sn $prefix $items[1] $suffix
			for item in $items[2..-2]
				echo-color $separator_style -n $separator
				echo-color $style -sn $prefix $item $suffix
			end
			echo-color $separator_style -n $last_separator
			echo-color $style -s $prefix $items[-1] $suffix
	end
end
