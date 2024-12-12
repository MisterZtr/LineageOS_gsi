TARGET_GAPPS_ARCH := arm64
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/phh/treble/base.mk)

$(call inherit-product, vendor/gapps/arm64/arm64-vendor.mk)
$(call inherit-product, device/phh/treble/lineage.mk)

PRODUCT_NAME := treble_arm64_bgN
PRODUCT_DEVICE := tdgsi_arm64_ab
PRODUCT_BRAND := google
PRODUCT_SYSTEM_BRAND := google
PRODUCT_MODEL := TrebleDroid

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_PACKAGES += 

LINEAGE_BUILDTYPE := GAPPS
LINEAGE_EXTRAVERSION := -EROFS
LINEAGE_BUILD := GSI
GSI_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_COMPRESSOR := lz4hc,9
