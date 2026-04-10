function set-rustup-mirror
	set -x RUSTUP_UPDATE_ROOT https://cloudfront-static.rust-lang.org/rustup
	set -x RUSTUP_DIST_SERVER https://cloudfront-static.rust-lang.org
end
