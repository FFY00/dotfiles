# Defined in /tmp/fish.uLaQpX/pp.fish @ line 2
function pp
	set -l package (find ~/git/arch/community/ -mindepth 1 -maxdepth 1 -type d -not -name '.*' -exec basename '{}' \; 2> /dev/null | fzf)
	set -l package_path ~/git/arch/community/"$package"/trunk
	if test -d $package_path
		cd "$package_path"
	end
end
