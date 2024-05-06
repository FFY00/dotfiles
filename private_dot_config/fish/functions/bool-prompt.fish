function bool-prompt --wraps=echo
	set prompt (echo-color blue $argv ' (y/n):')
	contains (read -n1 --prompt-str "$prompt") y Y
	return $status
end
