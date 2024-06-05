function pb --wraps='pkgctl build'
	pkgctl build $argv
	return $status
end
