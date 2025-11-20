function fzf-cd --argument dir --argument-names cmd_create --argument-names cmd_directory
	# config
	set find_filter_args		-mindepth 1 -maxdepth 1 -type d -not -name '.*'
	set find_output_args		-printf '%f\n'
	if test -z cmd_create
		set fzf_enter_action accept-or-print-query
	else
		set fzf_enter_action "transform:fzf-create '{q}' '{}' 'cd '$dir'; and $cmd_create' '$cmd_directory'"
	end
	set -a fzf_args			--preview="ls --color=always '$dir/{}'"
	set -a fzf_args			--with-shell='fish -c'
	set -a fzf_args			--bind="enter:$fzf_enter_action"
	# get user input
	set project (
		begin
			# add . as an option to allow going to the root
			echo .
			# find
			find -L $dir $find_filter_args $find_output_args
		end 2>/dev/null | fzf $fzf_args
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
