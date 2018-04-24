#!/usr/bin/env bash

mkdir build
cd build

export CXX=clang++
export CC=clang-6.0
export CFLAGS=-stdlib=libc++

cmake \
    -DCMAKE_BUILD_TYPE:STRING="Release" \
    -DCMAKE_CXX_FLAGS_RELEASE="-O2 -stdlib=libc++" \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_INSTALL_RPATH="${PREFIX}/lib" \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
    -DBUILD_BENCHMARKS=no \
    -DINTEGER_CLASS=gmp \
    -DWITH_SYMENGINE_THREAD_SAFE=yes \
    -DWITH_MPC=yes \
    -DBUILD_SHARED_LIBS=yes \
    -DWITH_LLVM=yes \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_SHARED_LINKER_FLAGS="-lc++" \
    ..

cmake --build .
cmake --build . --target install

ctest
