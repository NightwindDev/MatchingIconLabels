TARGET := iphone:clang:latest:14.0
ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MatchingIconLabels

MatchingIconLabels_FILES = Tweak.x
MatchingIconLabels_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
