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
rm -rf vendor/yaap-priv/keys
rm -rf vendor/qcom/opensource/core-utils
rm -rf packages/apps/KProfiles
rm -rf hardware/qcom/display
rm -rf hardware/qcom/media
rm -rf hardware/qcom/audio
rm -rf device/qcom/sepolicy_vndr

# Clone sources
git clone https://github.com/ShahzebQureshi/device_oneplus_hotdogg -b sixteen-test device/oneplus/hotdogg --depth=1
git clone https://github.com/yaap/device_oneplus_sm8150-common -b sixteen device/oneplus/sm8150-common --depth=1
git clone https://github.com/yaap/kernel_oneplus_sm8150 -b sixteen kernel/oneplus/sm8150 --depth=1
git clone https://github.com/ShahzebQureshi/vendor_oneplus_hotdogg -b main vendor/oneplus/hotdogg --depth=1
git clone https://github.com/yaap/vendor_oneplus_sm8150-common -b sixteen vendor/oneplus/sm8150-common --depth=1
git clone https://github.com/ShahzebQureshi/ak vendor/yaap-priv/keys --depth=1
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils -b sixteen vendor/qcom/opensource/core-utils --depth=1
git clone https://github.com/yaap/device_qcom_common -b sixteen device/qcom/common --depth=1
git clone https://gitlab.com/yaosp/vendor_qcom_common -b sixteen vendor/qcom/common --depth=1
git clone https://github.com/yaap/packages_apps_KProfiles -b sixteen packages/apps/KProfiles --depth=1

# Clone hardware LAST
git clone https://github.com/yaap/hardware_oneplus -b sixteen hardware/oneplus --depth=1

# Set up build environment
export BUILD_USERNAME=ShahzebQureshi
export BUILD_HOSTNAME=Linux
export TZ="Asia/Karachi"

# Build

. build/envsetup.sh
export SKIP_ABI_CHECKS=true
lunch yaap_hotdogg-userdebug
m bacon
