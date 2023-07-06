# Defined in /tmp/fish.dkUCBe/gm.fish @ line 2
function gm
	set -l options
	for i in (seq 1 (count $argv))
		set -x options $options -m $argv[$i]
	end
	command git commit $options
end
