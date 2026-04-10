function show-colors
	set -l colors black red green yellow blue magenta cyan white
	for color in $colors
		echo-color $color $color
	end
end
