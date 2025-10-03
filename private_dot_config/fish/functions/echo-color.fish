function echo-color
	set styles bold dim italics reverse underline

	set style_string $argv[1]
	set echo_args $argv[2..]

	# Build set_color_args from the style string.
	# Eg.:
	# 	dim+bold+red > '--dim --bold red'
	# 	dim+bold > '--dim --bold'
	for entry in (string split + $style_string)
		if contains $entry $styles
			set -a set_color_args "--$entry"
		else
			set -a set_color_args $entry
		end
	end
	set color (set_color $set_color_args)
	set reset (set_color normal)

	# If no arguments were passed to echo, read from stdin instead, but insert the
	# reset sequence in the last line, so that it does not start a new line.
	if test -z $echo_args
		set_color $set_color_args; and sed -z 's/\n$/'$(set_color normal)'\n/' <&0
	else
		set_color $set_color_args; and echo $echo_args
		set_color normal
	end
end
