# Defined in /tmp/fish.bTYNje/qemu-kernel-dev.fish @ line 2
function qemu-kernel-dev
	qemu-system-x86_64 \
		-kernel ~/git/linux/arch/x86/boot/bzImage \
		-drive file=fat:rw:~/chroot/kernel-dev \
		-append "root=/dev/sda rw console=ttyS0" \
		-m 4G \
		-nographic \
		-display none \
		-enable-kvm
end
