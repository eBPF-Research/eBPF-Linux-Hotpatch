self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`

build_vim() {
    echo "Building vim-8.1.1364 ..."

    cd ../vim-8.1.1364
    chmod 777 -R .
    make -j8
}

pushd ${self_dir}
build_vim
popd