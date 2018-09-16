function sup
	if [ (count $argv) = 0 ]
		echo "Missing package name..."
		return
	end
	command svn update $argv[1]
	cd $argv[1]/trunk
end
