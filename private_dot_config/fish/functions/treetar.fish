function treetar
	# Search for arch package in current directory if no file was passed
	test -z "$argv" && set -a argv (findpkg)

	for entry in $argv
		command tar -tf $entry 2> /dev/null | treeify
	end
end
