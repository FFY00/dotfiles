function pyproject-deps -d 'Print the Python project dependencies.'
	argparse h/help b/build-dependencies d/project-dependencies O/optional=+ -- $argv

	if set -ql _flag_h
		echo "usage: $_ [-b] [-O<GROUP>]+"
		echo
		echo "  -b, --build-dependencies        output the build dependencies (build-system.requires)"
		echo "  -d, --project-dependencies      output the base depedencies (project.dependencies)"
		echo "  -O, --optional=GROUP            output the depedencies from the specified optional group"
		echo "                                  (project.optional-dependencies.<GROUP>)"
		echo
		echo "Print the Python project dependencies."
		echo
		echo "By default all dependencies are printed — both base and all optional groups."
		echo "If either -b/--build-dependencies, -d/--project-dependencies or -O/--optional "
		echo "options are passed, only those dependencies are printed."
		echo
		echo "The -O/--optional option may be specified multiple times."
		return 1
	end >&2

	set -l items
	if set -ql _flag_b
		set -a items '."build-system".requires'
	end
	if set -ql _flag_d
		set -a items '.project.dependencies'
	end
	for group in $_flag_O
		set -a items ".project.\"optional-dependencies\".$group"
	end
	# If none were specified, print all
	if test (count $items) -eq 0
		set -a items '.project.dependencies' '.project."optional-dependencies"[]'
	end

	tomlq -r "($(string join ' + ' $items))[]" pyproject.toml
end
