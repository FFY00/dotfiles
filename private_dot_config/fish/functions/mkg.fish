# Defined in /tmp/fish.gmpveq/mkg.fish @ line 2
function mkg
	updpkgsums
	#command makepkg -g; or return
	#set sums (makepkg -g 2> /dev/null)
	#set line_count (math (count $sums) - 1)
	#set final ''
	#set i 0
	#for line in $sums
	#	set final $final$line
	#	if test $i -lt $line_count
	#		set final $final'\n'
	#	end
	#	set i (math $i + 1)
	#end
	#perl -0777 -i -pe "s/.*sums=\(\'(([a-z]|[A-Z]|[0-9]|\'| |\n)*)\)/$final/g" PKGBUILD
end
