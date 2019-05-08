export THEOS_DEVICE_IP=localhost -p 2222
TARGET = iphone:clang:9.2:9.2
ARCHS =  armv7 armv7s arm64 arm64e
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = sileonobanner
sileonobanner_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Sileo"
