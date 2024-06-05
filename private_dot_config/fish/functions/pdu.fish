function pdu --wraps='pkgctl db update'
	pkgctl db update $argv
	return $status
end
