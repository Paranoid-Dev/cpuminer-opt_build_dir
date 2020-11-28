```
sudo apt install libtool

...

<compile curl>
./buildconf

...

download libstdc++-6.dll
download libgcc_s_seh-1.dll

...

cd /cpuminer-opt
ln -s $LOCAL_LIB/gmp/gmp.h ./gmp.h
sed -i 's/"-lpthread"/"-lpthreadGC2"/g' configure.ac

...

./build.sh
```
