self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
script_args=("$@")
build_openssl() {
    echo "Building openssl-1.1.0b ..."

    cd ../openssl-1.1.0b
    make clean || true
    ./Configure linux-armv4 --prefix=/usr/local/openssl-1.1.0b --cross-compile-prefix=arm-linux-gnueabihf- ${script_args[@]}
    make -j
    make -j depend
    make -j install

    ln -s /usr/local/openssl-1.1.0b/bin/openssl ~/openssl
}

pushd ${self_dir}
build_openssl
popd
