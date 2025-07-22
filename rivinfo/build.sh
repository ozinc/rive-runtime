#!/bin/bash

# dir=$(pwd)

# cd ../renderer
# ./build.sh $@

# cd $dir

cd build

OPTION=$1

PREMAKE5_BIN="../../build/dependencies/premake-core/bin/release/premake5"

if [ "$OPTION" = 'help' ]; then
    echo build.sh - build debug library
    echo build.sh clean - clean the build
    echo build.sh release - build release library
elif [ "$OPTION" = "clean" ]; then
    echo Cleaning project ...
    # TODO: fix premake5 clean to bubble the clean command to dependent projects
    ${PREMAKE5_BIN} gmake2 && make clean
elif [ "$OPTION" = "release" ]; then
    ${PREMAKE5_BIN} gmake2 && make config=release -j7
else
    ${PREMAKE5_BIN} gmake2 && make -j7
fi
