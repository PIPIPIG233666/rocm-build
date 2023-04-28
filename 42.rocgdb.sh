#!/bin/bash

sh 41.rocdbgapi.sh
set -e

echo "|====|"
echo "|SLOW|"
echo "|====|"

mkdir -p $ROCM_BUILD_DIR/rocgdb
cd $ROCM_BUILD_DIR/rocgdb
pushd .

START_TIME=`date +%s`

CC=clang $ROCM_GIT_DIR/ROCgdb/configure --program-prefix=roc \
  --enable-64-bit-bfd --enable-targets="x86_64-linux-gnu,amdgcn-amd-amdhsa" \
  --disable-ld --disable-gas --disable-gdbserver --disable-sim --enable-tui \
  --disable-gdbtk --disable-gprofng --disable-shared --with-expat \
  --with-system-zlib --without-guile --without-babeltrace --with-lzma \
  --with-python=python3 \
  --with-rocm-dbgapi=/home/pppig/rocm-build/build/rocdbgapi/

make -j${nproc}
doas make install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

