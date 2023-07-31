self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`
set -e
build_vim() {
    echo "Building vim-8.1.1364 ..."

    cd ../vim-8.1.1364
    chmod 777 -R .
    make clean || true
    make distclean || true
    ./configure --enable-gui=no
    make -j
}

pushd ${self_dir}
build_vim
popd
