function svn-pkg-setup
	set -l folder (basename (pwd))
	if test $folder = 'trunk'
		echo "Changing directory..."
		cd ..
	end
	command svn add trunk/PKGBUILD
	command svn propset svn:keywords "Id" trunk/PKGBUILD
	command svn commit
	echo "Changing directory..."
	cd trunk
end
