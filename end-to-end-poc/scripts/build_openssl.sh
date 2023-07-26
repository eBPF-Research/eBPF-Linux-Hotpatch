self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
script_args=("$@")
build_openssl() {
    echo "Building openssl-1.1.0b ..."

    cd ../openssl-1.1.0b
    make distclean || true
    MACHINE_TYPE=`uname -m`
    if [[ ${MACHINE_TYPE} == 'x86_64' ]]; then
        ./Configure linux-x86_64 no-afalgeng --prefix=/usr/local/openssl-1.1.0b ${script_args[@]}
    elif [[  ${MACHINE_TYPE} == 'aarch64' ]]; then
        ./Configure linux-aarch64 no-afalgeng --prefix=/usr/local/openssl-1.1.0b ${script_args[@]}
    elif [[ ${MACHINE_TYPE} == 'armv7l' || ${MACHINE_TYPE} == 'armv6l' ]]; then
        ./Configure linux-armv4 no-afalgeng --prefix=/usr/local/openssl-1.1.0b ${script_args[@]}
    else
        echo "Unknown system type ${MACHINE_TYPE}"
        exit 1
    fi

    make -j

}

pushd ${self_dir}
build_openssl
popd
