################################################################################
# wifi-scripts Buildroot package
################################################################################

WIFI_SCRIPTS_VERSION = 1
WIFI_SCRIPTS_SITE = $(TOPDIR)/package/wifi-scripts
WIFI_SCRIPTS_LICENSE = GPL-2
WIFI_SCRIPTS_LICENSE_FILES =

define WIFI_SCRIPTS_INSTALL_TARGET_CMDS
	# Install scripts to /usr/bin with 755 permissions
	install -D -m 0755 $($(PKG)_SITE)/wifi-init.sh $(TARGET_DIR)/usr/bin/wifi-init.sh
	install -D -m 0755 $($(PKG)_SITE)/wifi-stop.sh $(TARGET_DIR)/usr/bin/wifi-stop.sh
endef

$(eval $(generic-package))
