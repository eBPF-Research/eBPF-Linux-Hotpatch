self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`

build_libevent() {
    echo "Building libevent-2.1.5-beta ..."

    cd ../libevent-2.1.5-beta
    make clean
    CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ ./configure --prefix=/usr/local/libevent-2.1.5-beta --disable-openssl --host=arm-linux-gnueabihf --disable-samples --disable-libevent-regress
    make -j8
    make install
}

pushd ${self_dir}
build_libevent
popd
