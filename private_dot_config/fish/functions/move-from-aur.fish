function move-from-aur
	if test (count $argv) -eq 0
		echo "Missing package name..."
		return
	end
	new-pkg-dir $argv[1]
	cp-from-aur $argv[1] PKGBUILD
end
