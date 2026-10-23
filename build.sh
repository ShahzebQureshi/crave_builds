#!/bin/bash
rm -rf .repo/local_manifests
repo init --no-repo-verify --git-lfs -u https://github.com/LineageOS/android.git -b lineage-24.0 -g default,-mips,-darwin,-notdefault
/opt/crave/resync.sh

# Clean old dirs
rm -rf out/target/product/hotdogg
rm -rf device/oneplus/hotdogg
rm -rf device/oneplus/sm8150-common
rm -rf kernel/oneplus/sm8150
rm -rf vendor/oneplus
rm -rf hardware/oplus
rm -rf vendor/lineage-priv/keys

# Clone sources
git clone https://github.com/ShahzebQureshi/android_device_oneplus_hotdogg -b hotdogg-24.0 device/oneplus/hotdogg --depth=1
git clone https://github.com/LineageOS/android_device_oneplus_sm8150-common -b lineage-24.0 device/oneplus/sm8150-common --depth=1
git clone https://github.com/LineageOS/android_kernel_oneplus_sm8150 -b lineage-24.0 kernel/oneplus/sm8150 --depth=1
git clone https://github.com/ShahzebQureshi/proprietary_vendor_oneplus_hotdogg -b lineage-24.0 vendor/oneplus --depth=1
git clone https://github.com/LineageOS/android_hardware_oplus -b lineage-24.0 hardware/oplus --depth=1

# Test signing keys (public template keys: testing only)
git clone https://github.com/ProjectInfinity-X/vendor_infinity-priv_keys-template vendor/lineage-priv/keys --depth=1
sed -i 's#infinity-priv#lineage-priv#g; s#/testkey#/releasekey#g' vendor/lineage-priv/keys/keys.mk

# Build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Ubuntu
export TZ="Asia/Karachi"

# Build
. build/envsetup.sh
breakfast hotdogg
mka bacon
