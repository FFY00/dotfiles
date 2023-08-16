function rmpkg
	if test -d trunk
		echo "Changing directory..."
		cd 'trunk'
	end
	if test -e 'PKGBUILD'
		set -lx files *.log *.pkg.* src pkg .SRCINFO
		rm -rf $files
	else
		echo "Folder doesn't contain a PKGBUILD..."
	end
end
