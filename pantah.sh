#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 17 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/pantah
rm -rf device/google/pantah
rm -rf device/google/pantah-kernels
rm -rf device/google/pantah-sepolicy
rm -rf device/google/gs201
rm -rf device/google/gs-common
rm -rf kernel/google/gs201
rm -rf vendor/google/panther
rm -rf hardware/google/pixel
rm -rf hardware/google/pixel-sepolicy
rm -rf vendor/infinity-priv/keys

# Clone sources
git clone https://github.com/ShahzebQureshi/device_google_pantah -b infinity device/google/pantah --depth=1
git clone https://github.com/yaap/device_google_gs201 device/google/gs201 --depth=1
git clone https://github.com/Infinity-X-Devices/device_google_gs-common -b 16-qpr2 device/google/gs-common --depth=1
git clone https://github.com/yaap/device_google_pantah-kernel device/google/pantah-kernels/6.1 --depth=1
git clone https://github.com/sidharthify/android_kernel_google_gs201 kernel/google/gs201 --depth=1
git clone https://github.com/yaap/vendor_google_panther vendor/google/panther --depth=1
git clone https://github.com/yaap/hardware_google_pixel hardware/google/pixel --depth=1
git clone https://github.com/yaap/hardware_google_pixel-sepolicy hardware/google/pixel-sepolicy --depth=1

# Signing keys
git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys-template vendor/infinity-priv/keys --depth=1
pushd vendor/infinity-priv/keys
pip install -r requirements.txt
./keys.sh
popd

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
export TARGET_INIT_VENDOR_LIB=""
export TARGET_SURFACEFLINGER_UDFPS_LIB=""
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_panther-userdebug
