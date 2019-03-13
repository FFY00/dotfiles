function mkg
	command makepkg -g; or return
	set -l sums (makepkg -g 2> /dev/null)
	set -l line_count (math (count $sums) - 1)
	set -l final ''
	set -l i 0
	for line in $sums
		set final $final$line
		if test $i -lt $line_count
			set final $final'\n'
		end
		set i (math $i + 1)
	end
	perl -0777 -i -pe "s/.*sums=\(\'(([a-z]|[A-Z]|[0-9]|\'| |\n)*)\)/$final/g" PKGBUILD
end
