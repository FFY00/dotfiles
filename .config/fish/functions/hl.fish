function hl
	if test (count $argv) -lt 2
		echo "Usage: highlight <file> <expression>" 
		return
	end
	grep --color -E '^|'$argv[2] $argv[1]
end
