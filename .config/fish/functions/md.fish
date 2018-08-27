function md
	if test (count $argv) -ge 1
		if test ! -e $argv[1]
			command mkdir $argv[1]
		end
		cd $argv[1]
	end
end
