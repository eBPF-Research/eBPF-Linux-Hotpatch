
self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e

# install legacy version automake-1.14 for build libevent
build_automake_1_14() {
	mkdir -p ${self_dir}/build
	if [ -f /usr/bin/aclocal-1.14 ]; then
		echo "aclocal-1.14 already installed"
		return
	fi
	if [ ! -d ${self_dir}/build/automake-1.14 ]; then
		cp ${self_dir}/../assets/automake-1.14.tar.gz ${self_dir}/build
		cd ${self_dir}/build 
		tar -zxvf automake-1.14.tar.gz
	fi
	cd ${self_dir}/build/automake-1.14
	./configure --prefix=/usr/local/automake-1.14
	make -j4 install
	ln -s /usr/local/automake-1.14/bin/aclocal-1.14 /usr/bin/aclocal-1.14
}

build_automake_1_14
