self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
script_args=("$@")
build_redis() {
    echo "Building redis-5.0-rc1 ..."

    cd ../redis-5.0-rc1
    make distclean || true
    make clean || true
    MACHINE_TYPE=`uname -m`
    if [[ ${MACHINE_TYPE} == 'x86_64' ]]; then
        echo "Extra args: ${script_args[@]}"
        make MALLOC=libc ${script_args[@]} -j
    elif [[ ${MACHINE_TYPE} == 'i686' || ${MACHINE_TYPE} == 'i386' ]]; then
        make MALLOC=libc ${script_args[@]} -j 32bit
    elif [[  ${MACHINE_TYPE} == 'aarch64' ]]; then
        make MALLOC=libs ${script_args[@]} FINAL_LIBS="-lm -latomic" -j 
    elif [[ ${MACHINE_TYPE} == 'armv7l' || ${MACHINE_TYPE} == 'armv6l' ]]; then
        echo "Extra args: ${script_args[@]}"
        make MALLOC=libs CFLAGS="-march=native" ${script_args[@]} FINAL_LIBS="-lm -latomic" -j 
    else
        echo "Unknown system type ${MACHINE_TYPE}"
        exit 1
    fi
    
}

pushd ${self_dir}
build_redis
popd
