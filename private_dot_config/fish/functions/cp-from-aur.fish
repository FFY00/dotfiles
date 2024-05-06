function cp-from-aur
	if [ (count $argv) = 0 ]
		echo "Missing package name..."
		return
	end
	set file 'PKGBUILD'
	if [ (count $argv) -ge 2 ]
		set -x file $argv[2]
	end
	if [ -e ~/git/pkg/$argv[1]/$file ]
		cp ~/git/pkg/$argv[1]/$file .
		svn add $file
	else
		echo "File doesn't exist..."
	end
end
