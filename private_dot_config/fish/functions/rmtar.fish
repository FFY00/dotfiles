function rmtar
	set -lx files *.tar.*
	rm -rf $files
end
