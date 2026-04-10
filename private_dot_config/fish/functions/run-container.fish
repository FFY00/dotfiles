function run-container --wraps=arch-nspawn --argument-names name
	arch-nspawn ~/.containers/$name \
		--user=anubis \
		--bind=/var/cache/pacman/pkg/ \
		--bind=/home/anubis
end
