function pb --wraps='pkgctl build'
	rmpt
	pkgctl build $argv
	return $status
end
