function findfiles
	if test (count $argv) -lt 2
		echo "Usage: findfile <directory> <expression>"
		return
	end
	grep -RHna $argv[1] -e $argv[2]
end
