$(call inherit-product, vendor/my4ndr0id/config/common.mk)

PRODUCT_PACKAGES += \
    NovaLauncher

# Inherit drm blobs
-include vendor/my4ndr0id/config/common_drm_phone.mk

