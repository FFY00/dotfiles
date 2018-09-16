function treetar
	command tar -tf $argv 2> /dev/null | treeify
end
