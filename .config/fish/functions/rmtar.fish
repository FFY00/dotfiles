function rmtar
	set -lx files *.tar.*
	for file in $files
		rm -rf $file
	end
end
