self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_redis() {
    echo "Building redis-5.0-rc1 ..."

    cd ../redis-5.0-rc1
    make distclean || true
    make CFLAGS="" LDFLAGS="" MALLOC=libc CC=arm-linux-gnueabihf-gcc CXX=arm-linux-gnueabihf-g++ AR=arm-linux-gnueabihf-ar RANLIB=arm-linux-gnueabihf-ranlib NM=arm-linux-gnueabihf-nm -j8
}

pushd ${self_dir}
build_redis
popd
