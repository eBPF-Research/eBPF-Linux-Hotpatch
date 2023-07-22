self_path=`readlink -f "${BASH_SOURCE:-$0}"`
self_dir=`dirname $self_path`

set -e

build_vim() {
    echo "Building vim-8.1.1364 ..."

    cd ../vim-8.1.1364
    chmod 777 -R .
    make clean
    make distclean
    LDFLAGS="-L/usr/local/ncurses-6.3/lib" vim_cv_getcwd_broken=no vim_cv_memmove_handles_overlap=yes vim_cv_stat_ignores_slash=yes vim_cv_tty_group=root vim_cv_tty_mode=0620  vim_cv_tgetent=zero vim_cv_terminfo=yes vim_cv_toupper_broken=yes ./configure --enable-gui=no -disable-gtktest --disable-xim --disable-gpm --without-x --disable-netbeans --with-tlib=ncurses --host=arm-linux-gnueabihf --disable-sysmouse --disable-selinux --disable-icon-cache-update --disable-smack
    make -j
}

pushd ${self_dir}
build_vim
popd
