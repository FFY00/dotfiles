function arg-set --no-scope-shadowing --argument-names name default
	if test -z $name
		echo-color red 'error: argument name not speficied (usage: arg-set <name> [default])' >&2
		return 2
	end

	set -l flag_name _flag_$name
	set $flag_name\_default $default
	if set -ql $flag_name
		set $name $$flag_name
		return 1
	else
		set $name $default
		return 0
	end
end
