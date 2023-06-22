function treetar
	for entry in $argv
		command tar -tf $entry 2> /dev/null | treeify
	end
end
