#
# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_BRAND ?= my4ndr0id

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/my4ndr0id/overlay/common

# aokp specific packages
PRODUCT_PACKAGES += \
    ROMControl \
    AppWidgetPicker \
    openvpn \
    SwagPapers \
    AOKPtips

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.error.receiver.system.apps=com.google.android.feedback \
    ro.com.google.locationfeatures=1 \
    ro.setupwizard.enterprise_mode=1 \
    windowsmgr.max_events_per_sec=240 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Backup Tool
PRODUCT_PACKAGES += \
    backuptool.sh \
    backuptool.functions \
    50-my4ndr0id.sh \
    efsbackup.sh

# init.d support
PRODUCT_PACKAGES += \
    00banner \
    sysinit \
    90userinit \
    00test

PRODUCT_COPY_FILES += \
    vendor/my4ndr0id/prebuilt/etc/mkshrc:system/etc/mkshrc

# T-Mobile theme engine
include vendor/my4ndr0id/config/themes_common.mk

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/my4ndr0id/prebuilt/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/my4ndr0id/prebuilt/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# koush superuser
PRODUCT_PACKAGES += \
    Superuser \
    .su \
    su \
    51-superuser.sh

# es file explorer
PRODUCT_PACKAGES += \
    es-file-explorer \
    libmyaes \
    libsapi_so_1

#
# CyanogenMod Audio Files
#

ALARM_PATH := vendor/my4ndr0id/prebuilt/media/audio/alarms
NOTIFICATION_PATH := vendor/my4ndr0id/prebuilt/media/audio/notifications
RINGTONE_PATH := vendor/my4ndr0id/prebuilt/media/audio/ringtones
UI_PATH := vendor/my4ndr0id/prebuilt/media/audio/ui

# Alarms
PRODUCT_COPY_FILES += \
	$(ALARM_PATH)/CyanAlarm.ogg:system/media/audio/alarms/CyanAlarm.ogg

# Notifications
PRODUCT_COPY_FILES += \
	$(NOTIFICATION_PATH)/CyanMail.ogg:system/media/audio/notifications/CyanMail.ogg \
	$(NOTIFICATION_PATH)/CyanMessage.ogg:system/media/audio/notifications/CyanMessage.ogg \
	$(NOTIFICATION_PATH)/CyanPing.ogg:system/media/audio/notifications/CyanPing.ogg \
	$(NOTIFICATION_PATH)/Doink.ogg:system/media/audio/notifications/Doink.ogg \
	$(NOTIFICATION_PATH)/Naughty.ogg:system/media/audio/notifications/Naughty.ogg \
	$(NOTIFICATION_PATH)/Pong.ogg:system/media/audio/notifications/Pong.ogg \
	$(NOTIFICATION_PATH)/Rang.ogg:system/media/audio/notifications/Rang.ogg \
	$(NOTIFICATION_PATH)/Stone.ogg:system/media/audio/notifications/Stone.ogg

# Ringtones
PRODUCT_COPY_FILES += \
	$(RINGTONE_PATH)/Bongo.ogg:system/media/audio/ringtones/Bongo.ogg \
	$(RINGTONE_PATH)/Boxbeat.ogg:system/media/audio/ringtones/Boxbeat.ogg \
	$(RINGTONE_PATH)/CyanTone.ogg:system/media/audio/ringtones/CyanTone.ogg \
	$(RINGTONE_PATH)/Gigolo.ogg:system/media/audio/ringtones/Gigolo.ogg \
	$(RINGTONE_PATH)/House_of_house.ogg:system/media/audio/ringtones/House_of_house.ogg \
	$(RINGTONE_PATH)/Silmarillia.ogg:system/media/audio/ringtones/Silmarillia.ogg

# set to EXPERIMENTAL for now
my4ndr0id_BUILDTYPE := EXPERIMENTAL
PRODUCT_VERSION_MAJOR = ics
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_MAINTENANCE = 0

# Set my4ndr0id_BUILDTYPE
ifdef my4ndr0id_NIGHTLY
    my4ndr0id_BUILDTYPE := NIGHTLY
endif
ifdef my4ndr0id_EXPERIMENTAL
    my4ndr0id_BUILDTYPE := EXPERIMENTAL
endif
ifdef my4ndr0id_RELEASE
    my4ndr0id_BUILDTYPE := RELEASE
endif

ifdef my4ndr0id_BUILDTYPE
    ifdef my4ndr0id_EXTRAVERSION
        # Force build type to EXPERIMENTAL
        my4ndr0id_BUILDTYPE := EXPERIMENTAL
        # Add leading dash to my4ndr0id_EXTRAVERSION
        my4ndr0id_EXTRAVERSION := -$(my4ndr0id_EXTRAVERSION)
    endif
else
    # If my4ndr0id_BUILDTYPE is not defined, set to UNOFFICIAL
    my4ndr0id_BUILDTYPE := UNOFFICIAL
    my4ndr0id_EXTRAVERSION :=
endif

ifdef my4ndr0id_RELEASE
    my4ndr0id_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(my4ndr0id_BUILD)
else
    my4ndr0id_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date -u +%Y%m%d)-$(my4ndr0id_BUILDTYPE)-$(my4ndr0id_BUILD)$(my4ndr0id_EXTRAVERSION)
endif

PRODUCT_PROPERTY_OVERRIDES += \
  ro.my4ndr0id.version=$(my4ndr0id_VERSION) \
  ro.modversion=$(my4ndr0id_VERSION)

otatime := $(shell date +%Y%m%d-%H%M)

# OTA Update Center settings
PRODUCT_PROPERTY_OVERRIDES += \
    otaupdater.otaid=my4ndr0id-eg909 \
    otaupdater.otaver=$(my4ndr0id_VERSION) \
    otaupdater.otatime=$(otatime) \
    otaupdater.sdcard.recovery=sdcard \
    otaupdater.sdcard.os=mnt/sdcard

PRODUCT_PACKAGES += \
    ota-update-centre
