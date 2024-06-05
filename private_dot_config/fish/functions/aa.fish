function aa
	set project (fzf-cd ~/git/arch/)
	# user specified a directory that doesn't exist
	if test $status -eq 1
		# clone directory
		cd ~/git/arch/
		command pkgctl repo clone $project
		# cd if successful or return the pkgctl exit code
		set pkgctl_status $status
		if test $pkgctl_status -eq 0
			cd $project
		else
			return $pkgctl_status
		end
	end
end
