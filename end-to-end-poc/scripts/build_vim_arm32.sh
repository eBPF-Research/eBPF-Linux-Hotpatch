self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`

set -e

build_vim() {
    echo "Building vim-8.1.1364 ..."

    cd ../vim-8.1.1364
    chmod 777 -R .
    make clean
    make distclean
    vim_cv_toupper_broken=yes ./configure --enable-gui=no -disable-gtktest --disable-xim --disable-gpm --without-x --disable-netbeans --with-tlib=ncurses --host=arm-linux-gnueabihf --disable-sysmouse --disable-selinux --disable-icon-cache-update --disable-smack
    # make CC=arm-linux-gnueabihf-gcc -j
}

pushd ${self_dir}
build_vim
popd
