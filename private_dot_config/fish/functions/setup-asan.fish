function setup-asan
	argparse --max-args 0 'h/help' 'r/recover' -- $argv; or return

	if set -ql _flag_h
		echo "usage: $_ [OPTION]"
		echo
		echo "  -h, --help      show this help message"
		echo "  -r, --recover   enable -fsanitize-recover=address and set halt_on_error=0"
		echo "                  (experimental, and may not be reliable)"
		return 1
	end >&2

	set -gx CC /usr/lib/ccache/bin/clang
	set -gx CXX /usr/lib/ccache/bin/clang++

	set -gx CFLAGS -fsanitize=address -fno-omit-frame-pointer
	set -gx CXXFLAGS -fsanitize=address -fno-omit-frame-pointer
	# We need to link against libraries we might not use directly
	# so that libasan can properly setup interceptors (eg. __cxa_throw)
	#set -gx LDFLAGS -Wl,--no-as-needed -static-libasan

	set -gx --path ASAN_OPTIONS \
		detect_leaks=0 \
		symbolize=1 \
		strict_init_order=true \
		allocator_may_return_null=1 \
		use_sigaltstack=0

	if set -ql _flag_r
		set -a CFLAGS -fsanitize-recover=address
		set -a CXXFLAGS -fsanitize-recover=address
		set -a ASAN_OPTIONS halt_on_error=0
		# CPython specific
		#if not contains -- -fsanitize-recover=address $EXTRA_CFLAGS
		#	set -gxa EXTRA_CFLAGS -fsanitize-recover=address
		#end
	end

	echo-color bold+yellow 'Configured environment as follows:'
	echo

	function echo-env-line
		echo -n '  '
		for var in $argv[1..-2]
			echo-color cyan+bold -n $var
			echo-color normal+cyan -n =
		end
		echo-color normal+blue $argv[-1]
	end

	echo-env-line CC $CC
	echo-env-line CXX $CXX
	echo-env-line CFLAGS CXXFLAGS "$CFLAGS"
	#echo-env-line LDFLAGS "$LDFLAGS"
	echo-env-line ASAN_OPTIONS "$ASAN_OPTIONS"

	#if set -q EXTRA_CFLAGS
	#	echo
	#	echo-color green '  (CPython specific)'
	#	echo
	#	echo-env-line EXTRA_CFLAGS "$EXTRA_CFLAGS"
	#end
end
