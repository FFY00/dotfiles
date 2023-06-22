function gg
	# config
	set -l gitdir			~/git
	set -l find_filter_args		-mindepth 1 -maxdepth 1 -type d -not -name '.*'
	set -l name_transform_cmd	basename {} \;
	set -l fzf_args			"--preview=ls --color=always $gitdir/{}"
	# execute
	set -l project (find $gitdir $find_filter_args -exec $name_transform_cmd | fzf $fzf_args)
	if ! test -z $project
		cd $gitdir/$project
	end
end
