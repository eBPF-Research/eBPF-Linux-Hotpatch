self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_redis() {
    echo "Building redis-5.0-rc1 ..."

    cd ../redis-5.0-rc1
    make distclean || true
    MACHINE_TYPE=`uname -m`
    if [[ ${MACHINE_TYPE} == 'x86_64' ]]; then
        make MALLOC=libc -j
    elif [[ ${MACHINE_TYPE} == 'i686' || ${MACHINE_TYPE} == 'i386' ]]; then
        make MALLOC=libc -j 32bit
    elif [[  ${MACHINE_TYPE} == 'aarch64' ]]; then
        make MALLOC=libs FINAL_LIBS="-lm -latomic" -j 
    elif [[ ${MACHINE_TYPE} == 'armv7l' || ${MACHINE_TYPE} == 'armv6l' ]]; then
        make MALLOC=libs CFLAGS="-march=native" FINAL_LIBS="-lm -latomic" -j 
    else
        echo "Unknown system type ${MACHINE_TYPE}"
        exit 1
    fi
    
}

pushd ${self_dir}
build_redis
popd
