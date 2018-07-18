#!/usr/bin/env bash

mkdir build
cd build

export CXX=clang++
export CC=clang-6.0
export CXXFLAGS=-stdlib=libc++

cmake \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DBUILD_BENCHMARKS=no \
    -DINTEGER_CLASS=flint \
    -DWITH_COTIRE=no \
    -DWITH_SYMENGINE_THREAD_SAFE=yes \
    -DWITH_MPC=yes \
    -DBUILD_FOR_DISTRIBUTION=yes \
    -DBUILD_SHARED_LIBS=yes \
    -DWITH_LLVM=yes \
    -DCMAKE_INSTALL_LIBDIR=lib \
    ..

make VERBOSE=1
cmake --build . --target install

ctest
