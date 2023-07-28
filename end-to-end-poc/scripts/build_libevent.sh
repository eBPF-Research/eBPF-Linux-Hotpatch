self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_libevent() {
    echo "Building libevent-2.1.5-beta ..."

    cd ../libevent-2.1.5-beta
    make clean || true
    make distclean || true
    MACHINE_TYPE=`uname -m`
    if [[ ${MACHINE_TYPE} == 'armv7l' || ${MACHINE_TYPE} == 'armv6l' ]]; then
        # export ASAN_OPTIONS=detect_leaks=0
        # ASAN_OPTIONS=detect_leaks=0 CFLAGS='-fomit-frame-pointer -fsanitize=address -latomic' 
        ./configure --prefix=/usr/local/libevent-2.1.5-beta --disable-openssl
    else
        CFLAGS='-fomit-frame-pointer -fsanitize=address' ./configure --prefix=/usr/local/libevent-2.1.5-beta --disable-openssl
    fi 
    make -j
    make install
}

pushd ${self_dir}
build_libevent
popd
