function gg
	# config
	set -l gitdir			~/git
	set -l find_filter_args		-mindepth 1 -maxdepth 1 -type d -not -name '.*'
	set -l name_transform_cmd	basename {} \;
	set -l fzf_args			--preview="ls --color=always $gitdir/{}"
	# get user input
	set -l project (
		begin
			# add . as an option to allow going to the root
			echo .
			# find
			find $gitdir $find_filter_args -exec $name_transform_cmd
		# use --print-query (and then tail -n1) to allow arbitrary input
		end | fzf --print-query $fzf_args | tail -n1
	)
	# change directory
	if ! test -z $project
		# cd to $gitdir first to leave the user there if $project doesn't exist
		cd $gitdir
		cd $project
	end
end
