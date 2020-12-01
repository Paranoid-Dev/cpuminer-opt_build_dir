#!/bin/bash

export LOCAL_LIB="`pwd`/lib"
export LDFLAGS="-L$LOCAL_LIB/curl/lib/.libs -L$LOCAL_LIB/gmp/.libs -L$LOCAL_LIB/openssl"
export CONFIGURE_ARGS="--with-curl=$LOCAL_LIB/curl --with-crypto=$LOCAL_LIB/openssl --host=x86_64-w64-mingw32"

rm cpuminer/cpu-miner.c || echo done
rm cpuminer/gmp.h || echo done

cd ..

ln -s `pwd`/cpu-miner.c `pwd`/cpuminer-opt_build_dir/cpuminer/cpu-miner.c
rm -rf release
cp -r cpuminer-opt_build_dir/dll release

cd cpuminer-opt_build_dir/cpuminer

ln -s $LOCAL_LIB/gmp/gmp.h ./gmp.h

make distclean || echo clean

rm -f config.status

./autogen.sh || echo done

CFLAGS="-O3 -march=znver1 -Wall" ./configure $CONFIGURE_ARGS

make -j 2

strip -s cpuminer.exe

cd ..
cd ..

mv cpuminer-opt_build_dir/cpuminer/cpuminer.exe release/cpuminer-zen.exe

# cd cpuminer
# make clean || echo clean
# make distclean || echo clean
# rm -f config.status