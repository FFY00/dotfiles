function upg
	if test (count $argv) -eq 0
		echo 'Usage: upg new-pkgver'
		return
	end
	if not test -e PKGBUILD
		echo "This directory doesn't contain a PKGBUILD"
		return
	end
	sed -i "s|pkgver=.*|pkgver=$argv[1]|" PKGBUILD
	sed -i 's|pkgrel=.*|pkgrel=1|' PKGBUILD
	mkg
end
