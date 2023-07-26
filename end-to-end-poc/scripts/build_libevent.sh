self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_libevent() {
    echo "Building libevent-2.1.5-beta ..."

    cd ../libevent-2.1.5-beta
    CFLAGS='-fomit-frame-pointer -fsanitize=address' ./configure --prefix=/usr/local/libevent-2.1.5-beta --disable-openssl
    make -j8
    make install
}

pushd ${self_dir}
build_libevent
popd
