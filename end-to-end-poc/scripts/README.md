# Notes on cross building for arm32

- Cross compiler is required. Install with `apt install gcc-arm-linux-gnueabihf`
- Some extra packages/libraries are required. See the `Dependencies` section
- Use `build_xxx_arm32.sh` in scripts

# Dependencies

## alocal-1.14 and alocal-1.15

They are required when configuring libevent and memcached. No need to cross compile them
- Download from `ftp://ftp.gnu.org/gnu/automake/automake-1.14.tar.gz`
- For each archive, extract it with `tar -zxvf automake-1.14.tar.gz`
- Run `./configure --prefix=/usr/local/automake-1.14` in the extracted folder`
- Run `make -j install`
- `ln -s /usr/local/automake-1.14/bin/aclocal-1.14 /usr/bin/aclocal-1.14`
- `ln -s /usr/local/automake-1.14/bin/automake-1.14 /usr/bin/automake-1.14`

Building `automake-1.15` is similar to `1.14`, but with all `1.14` strings being replaced to `1.15`


## memcached and libevent

libevent is a dependency of memcached. Build libevent first.

## nncurses and vim

ncurses is required by vim. Compile and install it by:
```bash
wget https://invisible-island.net/datafiles/release/ncurses.tar.gz
cd ncurses-6.3/
./configure --prefix=/usr/local/ncurses-6.3 --host=arm-linux-gnueabihf --without-tests --with-build-cc=gcc --without-progs
make -j
make install
```
# Notes

## libevent

I'v commented out the `evutil_secure_rng_add_bytes` function in evutil_rand.c. This function will call a function removed in the recent version glibc.
