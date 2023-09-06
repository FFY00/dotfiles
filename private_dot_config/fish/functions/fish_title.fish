function fish_title
	switch (status current-command)
		case fish
			echo fish @ (prompt_pwd)

		case '*'
			echo (status current-commandline)
	end
end
