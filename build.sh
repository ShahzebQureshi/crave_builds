#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/guacamole
rm -rf device/oneplus/guacamole
rm -rf device/oneplus/sm8150-common
rm -rf kernel/oneplus/sm8150
rm -rf vendor/oneplus/guacamole
rm -rf vendor/oneplus/sm8150-common
rm -rf hardware/oplus

# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_guacamole-Evox -b infinity device/oneplus/guacamole --depth=1
git clone https://github.com/Codecity001/device_oneplus_sm8150-common-1 device/oneplus/sm8150-common --depth=1
git clone https://github.com/Codecity001/android_kernel_oneplus_sm8150 kernel/oneplus/sm8150 --depth=1
git clone https://github.com/ShahzebQureshi/proprietary_vendor_oneplus_guacamole -b infinity vendor/oneplus/guacamole --depth=1
git clone https://github.com/Codecity001/vendor_oneplus_sm8150-common-1 vendor/oneplus/sm8150-common --depth=1

# Clone hardware LAST
git clone https://github.com/Codecity001/hardware_oneplus-1 hardware/oplus --depth=1

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch infinity_guacamole-userdebug
mka bacon
