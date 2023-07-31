curl -O http://ftp.us.debian.org/debian/dists/stable/main/installer-armhf/current/images/cdrom/initrd.gz
curl -O http://ftp.us.debian.org/debian/dists/stable/main/installer-armhf/current/images/cdrom/vmlinuz
curl -O -L https://cdimage.debian.org/debian-cd/current/armhf/iso-dvd/debian-12.1.0-armhf-DVD-1.iso

qemu-img create -f qcow2 debian-arm.sda.qcow2 100G