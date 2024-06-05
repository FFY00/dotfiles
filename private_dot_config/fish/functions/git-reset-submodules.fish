function git-reset-submodules
	git submodule foreach --recursive git reset --hard
end
