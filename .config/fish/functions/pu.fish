# Defined in /tmp/fish.NnZCAx/pu.fish @ line 2
function pu
	pp; and rmpt
	if test (basename (pwd)) = 'trunk'
		svn update ..
	end
end
