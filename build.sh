#!/bin/bash

# Resolve the directory this script is in and move one level up to get the project root
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$PROJECT_ROOT/build"
WEB_BUILD_DIR="$PROJECT_ROOT/docs"
EMSDK_DIR="$PROJECT_ROOT/vendor/emsdk"

# Function to build the project using CMake with C99
build() {
    echo "[INFO] Creating build files..."

    cmake -S . -B $BUILD_DIR -GNinja -DPLATFORM="Desktop" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_STANDARD=99
    cmake --build $BUILD_DIR

    emcmake cmake -S . -B $WEB_BUILD_DIR -GNinja -DPLATFORM="Web" -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_STANDARD=99
    emmake cmake --build $WEB_BUILD_DIR
}

run() {
    echo "[INFO] Running program.."
    cd "$BUILD_DIR/bin/Debug" || exit 1
    "./program"
}

# Function to clean the build directory
clean() {
    echo "[INFO] Cleaning build directory..."
    rm -rf "$BUILD_DIR"
}

# Main logic
case "$1" in
    build)
        build
        ;;
    run)
        run
        ;;
    web)
        build_web
        ;;
    clean)
        clean
        ;;
    "")
        build
        ;;
    *)
        echo "Usage: $0 {build|clean}"
        ;;
esac

