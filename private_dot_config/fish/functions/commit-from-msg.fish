function commit-from-msg
	command git rev-parse "HEAD^{/^$argv}"
	return $status
end
