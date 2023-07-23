self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
script_args=("$@")
build_openssl() {
    echo "Building openssl-1.1.0b ..."

    cd ../openssl-1.1.0b
    ./Configure linux-x86_64 no-afalgeng --prefix=/usr/local/openssl-1.1.0b ${script_args[@]}
    make -j

}

pushd ${self_dir}
build_openssl
popd
