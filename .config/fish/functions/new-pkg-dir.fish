function new-pkg-dir
	if test (count $argv) -eq 0
		echo "Missing package name..."
		return
	end
	set -lx dirs $argv[1]/{repos,trunk}
	for dir in $dirs
		if test ! -d $dir
			mkdir -p $dir
		end
	end
	cd $argv[1]
	svn add . 2> /dev/null
	cd trunk
end
