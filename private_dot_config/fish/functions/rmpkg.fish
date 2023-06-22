function rmpkg
	set -x folder (basename (pwd))
	if test $folder = 'trunk'
		set -x folder (echo $folder | sed "s|/$folder||g" | xargs basename)
	else if test -d trunk
		echo "Changing directory..."
		cd 'trunk'
	else
		return
	end
	if test -e 'PKGBUILD'
		set -lx files *.log *.pkg.* src pkg .SRCINFO
		for file in $files
			rm -rf $file
		end
	else
		echo "Folder doesn't contain a PKGBUILD..."
	end
end
