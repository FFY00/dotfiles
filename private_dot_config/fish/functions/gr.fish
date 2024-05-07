function gr --wraps 'git reset'
	if not bool-prompt 'Do you want to do a hard git reset?'
		return $status
	end
	if not bool-prompt 'Do you *really* want to do a hard git reset?'
		return $status
	end
	command git reset $argv
end
