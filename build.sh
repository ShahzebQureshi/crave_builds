#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/yaap/manifest -b sixteen -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/hotdogg
rm -rf device/oneplus/hotdogg
rm -rf device/oneplus/sm8150-common
rm -rf kernel/oneplus/sm8150
rm -rf vendor/oneplus/hotdogg
rm -rf vendor/oneplus/sm8150-common
rm -rf hardware/oneplus
rm -rf vendor/infinity-priv/keys
# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_hotdogg -b sixteen-test device/oneplus/hotdogg --depth=1
git clone https://github.com/yaap/device_oneplus_sm8150-common -b sixteen device/oneplus/sm8150-common --depth=1
git clone https://github.com/yaap/kernel_oneplus_sm8150 -b sixteen kernel/oneplus/sm8150 --depth=1
git clone https://github.com/yaap/vendor_oneplus_hotdog -b sixteen vendor/oneplus/hotdogg --depth=1
git clone https://github.com/yaap/vendor_oneplus_sm8150-common -b sixteen vendor/oneplus/sm8150-common --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/lineage-priv/keys --depth=1
git clone https://github.com/LineageOS/android_hardware_oneplus hardware/oneplus --depth=1





# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"


# Build
. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch yaap_hotdogg-userdebug
m bacon
