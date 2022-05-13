#!/bin/bash

set -xe

origin=$(pwd)
version=$(cd lz4 && git describe --tags --abbrev=0)

install=$origin/lmod/dist/$(arch)/lz4/$version
module=$origin/lmod/modules/$(arch)/lz4/

mkdir -p $install
mkdir -p $module

NJ=${NJ:-$(nproc)}
# ===============

# Compile & install lz4
rm -rf $install/*
cd lz4

make install -j$NJ\
    MOREFLAGS="-mtune=haswell -Wl,-z,now" \
    PREFIX="$install"

cd ..

# Setup the module file
cp lz4.lua $module/$version.lua

sed -i -e "s@\${package}@lz4@g" $module/$version.lua
sed -i -e "s@\${version}@$version@g" $module/$version.lua
