function pr --wraps='pkgctl release'
	pkgctl release $argv
	return $status
end
