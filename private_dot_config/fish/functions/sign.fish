function sign
	for FILE in $argv
		if test (string split . $FILE)[-1] != 'sig'
			echo "Signing $FILE..."
			command gpg --detach-sign --use-agent --no-armor --yes -u 46F633CBB0EB4BF2 $FILE
		end
	end
	set rm *.sig.sig
	if test (count $rm) -ge 1
		rm *.sig.sig
	end
end
