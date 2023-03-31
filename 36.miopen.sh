#!/bin/bash

set -e
#
# git clone https://github.com/nlohmann/json.git
# cd json && mkdir build && cd build
# cmake ..
# make -j24
# doas make install

# git clone git clone https://github.com/boostorg/boost
# git co 5df8086b733798c8e08e316626a16babe11bd0d2
# git submodule update --init
# ./bootstrap.sh --with-toolset=clang
# doas ./b2 install
#
# doas cmake -P $ROCM_GIT_DIR/MIOpen/install_deps.cmake --prefix /usr/local
#
mkdir -p $ROCM_BUILD_DIR/miopen
cd $ROCM_BUILD_DIR/miopen
pushd .

START_TIME=`date +%s`

CXX=$ROCM_INSTALL_DIR/llvm/bin/clang++ cmake \
    -DAMDGPU_TARGETS=$AMDGPU_TARGETS \
    -DCMAKE_BUILD_TYPE=Release \
    -DMIOPEN_USE_MLIR=0 \
    -DCMAKE_INSTALL_PREFIX=$ROCM_INSTALL_DIR \
    -G Ninja \
    $ROCM_GIT_DIR/MIOpen

ninja
doas ninja install

END_TIME=`date +%s`
EXECUTING_TIME=`expr $END_TIME - $START_TIME`
echo "elapse : "$EXECUTING_TIME"s"

popd

