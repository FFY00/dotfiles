function load-env --argument-names file
	set potential_files .env env
	set -a filters -e 's/^[[:space:]]//'	# Remove trailing whitespace
	set -a filters -e '/^$/d'		# Remove empty lines
	set -a filters -e '/^#/d'		# Remove lines starting with # (comments)

	# Set default
	if test -z $file
		set file (path filter -f $potential_files | head -n1)
		if test -z $file
			echo-color red 'error: environment file not specified and could not find an existing one on the current path' >&2
		end
	end

	# Export variables from file
	echo -n "Reading $(string escape $file | echo-color bold)... "
	sed $filters $file | while read -d= name value
		set -gx $name $value
		set -a exported_vars $name
	end

	# Print exported
	if test -z $exported_vars
		echo 'no variables loaded'
	else
		#echo " loaded $(string join ', ' $exported_vars)"
		echo " loaded $(string-join-readable --prefix $(set_color yellow) --suffix $(set_color normal) $exported_vars)"
	end
end
