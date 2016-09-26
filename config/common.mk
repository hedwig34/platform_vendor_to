PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Include OctOS bootanimation
include vendor/to/config/bootanimation.mk

#substratum
PRODUCT_COPY_FILES += \
vendor/to/prebuilt/common/apk/substratum.apk:system/app/substratum/substratum.apk

#Pixel Launcher
PRODUCT_COPY_FILES += \
vendor/to/prebuilt/common/apk/PixelLauncherPrebuilt.apk:system/priv-app/nexus-launcher/PixelLauncherPrebuilt.apk \
vendor/to/prebuilt/common/apk/WallpaperPickerGooglePrebuilt.apk:system/app/nexus-launcher/WallpaperPickerGooglePrebuilt.apk

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.config.alarm_alert=Oxygen.ogg \
    ro.config.ringtone=Orion.ogg \
    ro.config.notification_sound=Tethys.ogg \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.build.selinux=1 \
    ro.com.android.dataroaming=false

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/to/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/to/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/to/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Init file
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.local.rc:root/init.du.rc

# Copy LatinIME for gesture typing
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so \
    vendor/to/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so \
    vendor/to/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so \
    vendor/to/prebuilt/common/lib64/libjni_latinimegoogle.so:system/lib64/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/mkshrc:system/etc/mkshrc \

PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/to/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/to/prebuilt/common/bin/sysinit:system/bin/sysinit

# Stagefright FFMPEG plugin
ifneq ($(BOARD_USES_QCOM_HARDWARE),true)
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so
endif

# Packages
include vendor/to/config/packages.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/to/overlay/common

# SuperSU
PRODUCT_COPY_FILES += \
    vendor/to/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
    vendor/to/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# Versioning System
ANDROID_VERSION = 7.0
TO_VERSION = 7.0
ifndef TO_BUILD_TYPE
    TO_BUILD_TYPE := OCT-N
    PLATFORM_VERSION_CODENAME := COMMUNITY
endif

#Build DU-Updater only if TO_BUILD_TYPE isn't COMMUNITY
#ifneq ($(TO_BUILD_TYPE),COMMUNITY)
#PRODUCT_PACKAGES += \
#    DU-Updater
#endif

# easy way to extend to add more packages
-include vendor/extra/product.mk

# Set all versions
TO_VERSION := TO_$(TO_BUILD)_$(ANDROID_VERSION)_$(shell date -u +%Y%m%d-%H%M).$(TO_VERSION)-$(TO_BUILD_TYPE)
TO_MOD_VERSION := TO_$(TO_BUILD)_$(ANDROID_VERSION)_$(shell date -u +%Y%m%d-%H%M).$(TO_VERSION)-$(TO_BUILD_TYPE)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.to.version=$(TO_VERSION) \
    ro.mod.version=$(TO_BUILD_TYPE)-OCT-N

<<<<<<< HEAD
=======
# Include OctOS versioning
include vendor/to/config/to_versioning.mk

# Extra Optional packages
 PRODUCT_PACKAGES += \
     masquerade
>>>>>>> 59612ef... substratum:add apk to rom
