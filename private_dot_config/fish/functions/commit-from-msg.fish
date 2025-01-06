function commit-from-msg
	set escaped_msg (string escape --style=regex "$argv")
	command git rev-parse "HEAD^{/^$escaped_msg}"
	return $status
end
