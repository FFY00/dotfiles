function fzf-cd --argument dir
	# config
	set find_filter_args		-mindepth 1 -maxdepth 1 -type d -not -name '.*'
	set name_transform_cmd	basename {} \;
	set fzf_args			--preview="ls --color=always $dir/{}"
	# get user input
	set project (
		begin
			# add . as an option to allow going to the root
			echo .
			# find
			find $dir $find_filter_args -exec $name_transform_cmd
		# use --print-query (and then tail -n1) to allow arbitrary input
		end 2>/dev/null | fzf --print-query $fzf_args | tail -n1
	)
	# directory doesn't exist
	if ! test -e $dir/$project
		echo $project
		# cd to $dir first to leave the user there if $project doesn't exist
		cd $dir
		return 1
	end
	# change directory
	if ! test -z $project
		cd $dir/$project
	end
end
