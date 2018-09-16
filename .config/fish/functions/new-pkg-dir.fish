function new-pkg-dir
	if test (count $argv) -eq 0
		echo "Missing package name..."
		return
	end
	if test -d $argv[1]
		echo "Directory already exists..."
		return
	end
	set -lx dirs $argv[1]/{repos,trunk}
	for dir in $dirs
		if test ! -d $dir
			mkdir -p $dir
		end
	end
	cd $argv[1]

	# Setup svn
	command svn add . 2> /dev/null
	svn commit -m "add root structure"

	cd trunk

	# Setup PKGBUILD
	touch PKGBUILD
#	echo "# \$Id\$"\n"# Maintainer: Filipe Laíns (FFY00) <lains@archlinux.org>" > PKGBUILD
	echo "# Maintainer: Filipe Laíns (FFY00) <lains@archlinux.org>" > PKGBUILD
	command svn add PKGBUILD
#	command svn propset svn:keywords "Id" PKGBUILD
end
