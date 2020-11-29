#!/bin/bash

cp -r dll release
export LOCAL_LIB="`pwd`/lib"
export LDFLAGS="-L$LOCAL_LIB/curl/lib/.libs -L$LOCAL_LIB/gmp/.libs -L$LOCAL_LIB/openssl"
ln -s $LOCAL_LIB/gmp/gmp.h ./gmp.h

cd cpuminer

make distclean || echo clean

rm -f config.status

./autogen.sh || echo done

CFLAGS="-O3 -march=znver1 -Wall" ./configure "--with-curl=$LOCAL_LIB/curl --with-crypto=$LOCAL_LIB/openssl --host=x86_64-w64-mingw32"

make -j 2

strip -s cpuminer.exe

cd ..

mv cpuminer/cpuminer.exe release/cpuminer-zen.exe

# cd cpuminer
# make clean || echo clean
# make distclean || echo clean
# rm -f config.status