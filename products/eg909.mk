# Inherit AOSP device configuration for inc.
$(call inherit-product, device/hisense/eg909/full_eg909.mk)

# Inherit some common aokp stuff.
$(call inherit-product, vendor/my4ndr0id/config/common_phone.mk)


#
# Setup device specific product configuration.
#
PRODUCT_NAME := aokp_my4ndr0id_eg909
PRODUCT_BRAND := hacksense eg909
PRODUCT_DEVICE := eg909
PRODUCT_MODEL := Andromaxi
PRODUCT_MANUFACTURER := Hisense
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_ID=IML74K BUILD_FINGERPRINT=hacksense/eg909/eg9909/eg909:E667.6.09.00.IDCS:user/release-keys PRIVATE_BUILD_DESC="E667.6.09.00.IDCS release-keys"

PRODUCT_PACKAGES += \
    Camera

# boot animation
PRODUCT_COPY_FILES += \
	vendor/my4ndr0id/prebuilt/bootanimation/bootanimation_480_800.zip:system/media/bootanimation.zip
