function findpkg
	# Default to the current directory if no directory was passed
	test -z "$argv" && set -a argv .

	find $argv \
		-name '*.pkg.*' \
		-not -name '*-debug-*' \
		-not -name '*.log'
end
