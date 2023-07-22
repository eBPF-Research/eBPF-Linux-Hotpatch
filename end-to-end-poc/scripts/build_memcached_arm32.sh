self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_memcached() {
    echo "Building memcached-1.4.32 ..."

    cd ../memcached-1.4.32
    make clean || true
    CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ ./configure --prefix=/usr/local/memcached-1.4.32 --host=arm-linux-gnueabihf --with-libevent=/usr/local/libevent-2.1.5-beta --disable-sasl
    # make -j8
    # make install 

    ln -s /usr/local/memcached-1.4.32/bin/memcached ~/memcached
}

pushd ${self_dir}
build_memcached
popd
