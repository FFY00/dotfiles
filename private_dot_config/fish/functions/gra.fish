function gra --wraps='git remote add' --argument name url
	if test -z $name
		echo-color red "usage: $_ <name> [url]" >&2
		return 1
	end
	if test -z $url
		set origin (git config --get remote.origin.url)
		if test $status -ne 0
			echo-color red "error: Unable to find 'origin' remote." >&2
			return 1
		end

		# Parse the origin URL -- [scheme]:(//[authority]/)[path](?query)(#fragment)
		set base_parts (string split -m1 : $origin)
		set scheme $base_parts[1]
		set path (string split / $base_parts[2])
		if string match -q '//*' $base_parts[2]
			set authority $path[3]
			set path $path[4..]
		end

		# Set URL to the same as origin but replacing the path base with the name of remote.
		# This should be the desired behavior in most cases when adding remotes for forks.
		# Examples:
		# - "git@gitlab.com:a/b/c/repo.git" to "git@gitlab.com:$name/repo.git"
		# - "https://gitlab.com/a/b/c/repo.git" to "https://gitlab.com/$name/repo.git"
		set url $scheme:(string join / $authority $name $path[-1])
	end
	run-command git remote add $name $url
	run-command git fetch $name
	return $status
end
