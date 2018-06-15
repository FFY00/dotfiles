function rma
	if test (basename (pwd)) = "build"
		rm -rf *
		rm -rf .*
	else
		echo "You are not in a 'build' directory!"
	end
end
