function grf --wraps='git reset --hard'
	if not bool-prompt 'Do you want to do a hard git reset?'
		return $status
	end
	if not bool-prompt 'Do you *really* want to do a hard git reset?'
		return $status
	end
	command git reset --hard $argv
end
