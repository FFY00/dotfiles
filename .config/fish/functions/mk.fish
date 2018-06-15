function mk
	command makepkg -f
	command makepkg --printsrcinfo > .SRCINFO
end
