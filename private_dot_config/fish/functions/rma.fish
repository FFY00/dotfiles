function rma
	if test (basename (pwd)) = "build"
		set -lx files * .*
		for file in $files
			rm -rf $file
		end
	else
		echo "You are not in a 'build' directory!"
	end
end
