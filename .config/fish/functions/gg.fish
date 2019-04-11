function gg
	set -l project_path (find ~/git -mindepth 1 -maxdepth 1 -type d -not -name '.*' -exec basename '{}' \; | fzf | xargs -r -I '{}' echo ~/git/'{}')
	if ! test -z $project_path
		cd "$project_path"
	end
end
