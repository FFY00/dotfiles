function commit-num --argument commit
	if test -z $commit
		set commit HEAD
	end
	command git rev-list --count $commit
	return $status
end
