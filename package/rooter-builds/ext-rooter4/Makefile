#Owned by DairyMan@Whirlpool
#
#Copyright GNU act.
include $(TOPDIR)/rules.mk

PKG_NAME:=ext-rooter4
PKG_VERSION:=1.000
PKG_RELEASE:=1

PKG_MAINTAINER:=Created by DM/makefile by Cobia@whirlpool
include $(INCLUDE_DIR)/package.mk

define Package/ext-rooter4
  SECTION:=utils
  CATEGORY:=ROOter
  DEPENDS:=+luci +ext-rooter-basic \
		+ca-bundle +ca-certificates +libustream-openssl \
		+luci-app-sqm +kmod-sched-cake \
		+luci-app-ddns +ddns-scripts +ddns-scripts_no-ip_com \
		+ext-command +ext-p910nd \
		+luci-app-hotspot +ext-extra +luci-app-guestwifi \
		+picocom +wpad-mini +wget +nano
  TITLE:=ROOter support for 4meg routers
  PKGARCH:=all
endef

define Package/ext-rooter4/description
  Helper scripts to install ROOter on 4meg routers
endef

define Build/Compile
endef

define Package/ext-rooter4/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,ext-rooter4))
