self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`

build_redis() {
    echo "Building redis-5.0-rc1 ..."

    cd ../redis-5.0-rc1
    make MALLOC=libc -j8
}

pushd ${self_dir}
build_redis
popd
