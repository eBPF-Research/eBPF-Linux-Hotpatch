self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_openssl() {
    echo "Building openssl-1.1.0b ..."

    cd ../openssl-1.1.0b
    ./Configure linux-aarch64 no-afalgeng --prefix=/usr/local/openssl-1.1.0b
    make -j8
    make install

}

pushd ${self_dir}
build_openssl
popd
