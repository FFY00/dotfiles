# Defined in /tmp/fish.uLaQpX/pp.fish @ line 2
function pp
	set -l package_path (find ~/git/arch/community/ -mindepth 1 -maxdepth 1 -type d -not -name '.*' -exec basename '{}' \; | fzf | xargs -r -I '{}' echo ~/git/arch/community/'{}'/trunk)
	if ! test -z $package_path
		cd "$package_path"
	end
end
