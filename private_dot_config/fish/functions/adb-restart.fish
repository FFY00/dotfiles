function adb-restart --wraps=adb
	run-command adb kill-server
	and run-command adb start-server
	and run-command adb devices
end
