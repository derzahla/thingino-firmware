WIFI_RTL8189FS_SITE_METHOD = git
WIFI_RTL8189FS_SITE = https://github.com/gtxaspec/rtl8189fs-wifi
WIFI_RTL8189FS_SITE_BRANCH = master
WIFI_RTL8189FS_VERSION = e78756219d4d437d8ccb9b9b1db703ac920716ba
# WIFI_RTL8189FS_VERSION =  $(shell git ls-remote $(WIFI_RTL8189FS_SITE) $(WIFI_RTL8189FS_SITE_BRANCH) | head -1 | cut -f1)

WIFI_RTL8189FS_LICENSE = GPL-2.0
WIFI_RTL8189FS_LICENSE_FILES = COPYING

WIFI_RTL8189FS_MODULE_MAKE_OPTS = \
	KSRC=$(LINUX_DIR) \
	KVER=$(LINUX_VERSION_PROBED) \
	CONFIG_RTL8189FS=m \
	CONFIG_SDIO_HCI=y \
	CONFIG_POWER_SAVING=n \
	CONFIG_REDUCE_TX_CPU_LOADING=n \
	CONFIG_ANTENNA_DIVERSITY=n \
	CONFIG_TRAFFIC_PROTECT=y \
	CFLAGS+="-DCONFIG_LITTLE_ENDIAN -DCONFIG_MINIMAL_MEMORY_USAGE"

define WIFI_RTL8189FS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_WLAN)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WIRELESS_EXT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_CORE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PROC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WEXT_PRIV)
	$(call KCONFIG_SET_OPT,CONFIG_CFG80211,y)
	$(call KCONFIG_SET_OPT,CONFIG_MAC80211,y)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_MINSTREL_HT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MAC80211_RC_DEFAULT_MINSTREL)
	$(call KCONFIG_SET_OPT,CONFIG_MAC80211_RC_DEFAULT,"minstrel_ht")
endef

define WIFI_RTL8189FS_INSTALL_CONFIGS
        $(INSTALL) -m 755 -d $(TARGET_DIR)/lib/firmware
        $(INSTALL) -m 644 -t $(TARGET_DIR)/lib/firmware $(WIFI_RTL8189FS_PKGDIR)/files/PHY_REG_PG.txt
endef

WIFI_RTL8189FS_POST_INSTALL_TARGET_HOOKS += WIFI_RTL8189FS_INSTALL_CONFIGS

$(eval $(kernel-module))
$(eval $(generic-package))
