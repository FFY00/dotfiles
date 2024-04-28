function pci
	GIT_CONFIG_GLOBAL= pre-commit install

	# This shouldn't be needeed now that we have a global pre-commit hook that runs the local one
	#
	# Set hooksPath back to the default
	#sed 's|\[core\]|[core]\n\thooksPath = .git/hooks|' .git/config
end
