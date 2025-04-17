function aur-clone --argument-names package
	run-command git clone ssh://aur@aur.archlinux.org/$package.git
end
