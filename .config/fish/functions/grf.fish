function grf
	read -l -n 1 -P 'Do you want to do a hard git reset? (y/n) ' confirm
	if test "$confirm" != 'y' -a "$confirm" != 'Y'
		echo 'Reset aborted.'
		return
	end
	read -l -n 1 -P 'Do you *really* want to do a hard git reset? (y/n) ' confirm
	if test "$confirm" != 'y' -a "$confirm" != 'Y'
		echo 'Reset aborted.'
		return
	end
	command git reset --hard $argv
end
