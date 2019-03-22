include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkPowerSelector
DarkPowerSelector_FILES = Tweak.xm

export ARCHS=arm64
export SDKVERSION=11.2

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
