INGENIC_LIB_SITE_METHOD = git
INGENIC_LIB_SITE = https://github.com/gtxaspec/ingenic-lib
INGENIC_LIB_SITE_BRANCH = master
INGENIC_LIB_VERSION = aea63e6f0d7821fdb62d8fc9259beebf065f0c47
# $(shell git ls-remote $(INGENIC_LIB_SITE) $(INGENIC_LIB_SITE_BRANCH) | head -1 | cut -f1)
INGENIC_LIB_INSTALL_STAGING = YES

INGENIC_LIB_LICENSE = GPL-2.0
INGENIC_LIB_LICENSE_FILES = COPYING

ifeq ($(BR2_SOC_FAMILY_INGENIC_T40)$(BR2_SOC_FAMILY_INGENIC_T41)$(BR2_SOC_FAMILY_INGENIC_A1),y)
	LIBALOG_FILE = $(@D)/$(SOC_FAMILY_CAPS)/lib/$(SDK_VERSION)/$(SDK_LIBC_NAME)/$(SDK_LIBC_VERSION)/libalog.so
else
	# Install libalog.so from T31 1.1.6 for every XBurst1 SoC
	# 40032d0802b86f3cfb0b2b13d866556e
	LIBALOG_FILE = $(@D)/T31/lib/1.1.6/$(SDK_LIBC_NAME)/$(SDK_LIBC_VERSION)/libalog.so
endif

define INGENIC_LIB_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 644 -t $(STAGING_DIR)/usr/lib/ $(@D)/$(SOC_FAMILY_CAPS)/lib/$(SDK_VERSION)/$(SDK_LIBC_NAME)/$(SDK_LIBC_VERSION)/*.so; \
	$(INSTALL) -m 644 -t $(STAGING_DIR)/usr/lib/ $(LIBALOG_FILE)
endef

define INGENIC_LIB_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/lib
	$(INSTALL) -m 644 -t $(TARGET_DIR)/usr/lib/ $(@D)/$(SOC_FAMILY_CAPS)/lib/$(SDK_VERSION)/$(SDK_LIBC_NAME)/$(SDK_LIBC_VERSION)/*.so; \
	$(INSTALL) -m 644 -t $(TARGET_DIR)/usr/lib/ $(LIBALOG_FILE)
endef

$(eval $(generic-package))
