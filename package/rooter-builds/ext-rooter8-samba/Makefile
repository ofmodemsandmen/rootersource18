#Owned by DairyMan@Whirlpool
#
#Copyright GNU act.
include $(TOPDIR)/rules.mk

PKG_NAME:=ext-rooter8-samba
PKG_VERSION:=1.000
PKG_RELEASE:=1

PKG_MAINTAINER:=Created by DM/makefile by Cobia@whirlpool
include $(INCLUDE_DIR)/package.mk

define Package/ext-rooter8-samba
  SECTION:=utils
  CATEGORY:=ROOter
  DEPENDS:=+luci +ext-rooter4 \
		+luci-app-samba +usb-storage 
  TITLE:=ROOter support for 8meg routers with Samba but w/o OpenVPN
  PKGARCH:=all
endef

define Package/ext-rooter8-samba/description
  Helper scripts to enable ROOter on 8meg routers with Samba but w/o OpenVPN
endef


define Build/Compile
endef

define Package/ext-rooter8-samba/install
	$(CP) ./files/* $(1)/


endef

$(eval $(call BuildPackage,ext-rooter8-samba))
