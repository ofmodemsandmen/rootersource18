#
# Copyright (C) 2009-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

include $(TOPDIR)/rules.mk

PKG_NAME:=bird
PKG_VERSION:=1.6.8
PKG_RELEASE:=1

PKG_SOURCE:=bird-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=ftp://bird.network.cz/pub/bird
PKG_HASH:=6c61ab5d2ef59d2559a8735b8252b5a0238013b43e5fb8a96c5d9d06e7bc00b2
PKG_BUILD_DEPENDS:=ncurses readline
PKG_MAINTAINER:=Álvaro Fernández Rojas <noltari@gmail.com>

PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define Package/bird/Default
  TITLE:=The BIRD Internet Routing Daemon
  URL:=https://bird.network.cz/
  DEPENDS:=+libpthread
endef

define Package/birdc/Default
  TITLE:=The BIRD command-line client
  URL:=https://bird.network.cz/
  DEPENDS:= +libreadline +libncurses
endef

define Package/birdcl/Default
  TITLE:=The BIRD lightweight command-line client
  URL:=https://bird.network.cz/
endef

define Package/bird/Default/description1
BIRD is an internet routing daemon which manages TCP/IP routing tables
with support of modern routing protocols, easy to use configuration
interface and powerful route filtering language. It is lightweight and
efficient and therefore appropriate for small embedded routers.

endef

define Package/bird/Default/description2
In BGP, BIRD supports communities, multiprotocol extensions, MD5
authentication, 32bit AS numbers and could act as a route server or a
route reflector. BIRD also supports multiple RIBs, multiple kernel
routing tables and redistribution between the protocols with a powerful
configuration syntax.

endef

define Package/bird/Default/description3
This is a BIRD command-line client. It is used to send commands to BIRD,
commands can perform simple actions such as enabling/disabling of
protocols, telling BIRD to show various information, telling it to show
a routing table filtered by a filter, or asking BIRD to reconfigure.

Unless you can't afford dependency on ncurses and readline, you
should install BIRD command-line client together with BIRD.

endef

define Package/bird/Default/description4
This is a BIRD lightweight command-line client. It is used to send commands to BIRD,
commands can perform simple actions such as enabling/disabling of
protocols, telling BIRD to show various information, telling it to show
a routing table filtered by a filter, or asking BIRD to reconfigure.

endef

define Package/bird4
$(call Package/bird/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv4)
endef

define Package/birdc4
$(call Package/birdc/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv4)
  DEPENDS+= +bird4
endef

define Package/birdcl4
$(call Package/birdcl/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv4)
  DEPENDS+= +bird4
endef

define Package/bird6
$(call Package/bird/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv6)
endef

define Package/birdc6
$(call Package/birdc/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv6)
  DEPENDS+= +bird6
endef

define Package/birdcl6
$(call Package/birdcl/Default)
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=Routing and Redirection
  TITLE+= (IPv6)
  DEPENDS+= +bird6
endef

define Package/bird4/description
$(call Package/bird/Default/description1)
This is IPv4 version of BIRD, it supports OSPFv2, RIPv2 and BGP
protocols.

$(call Package/bird/Default/description2)
endef

define Package/birdc4/description
$(call Package/bird/Default/description1)
$(call Package/bird/Default/description3)
endef

define Package/birdcl4/description
$(call Package/bird/Default/description1)
$(call Package/bird/Default/description4)
endef

define Package/bird6/description
$(call Package/bird/Default/description1)
This is IPv6 version of BIRD, it supports OSPFv3, RIPng and BGP
protocols.

$(call Package/bird/Default/description2)
endef

define Package/birdc6/description
$(call Package/bird/Default/description1)
$(call Package/bird/Default/description3)
endef

define Package/birdcl6/description
$(call Package/bird/Default/description1)
$(call Package/bird/Default/description4)
endef

CONFIGURE_ARGS += --with-linux-headers="$(LINUX_DIR)"

TARGET_CFLAGS+=-std=gnu89

define Build/Template

$(STAMP_BUILT)-$(2): $(STAMP_PREPARED)
	$(call Build/Configure/Default,$(3))
	$(call Build/Compile/Default,)
	( cd $(PKG_BUILD_DIR); mv -f bird bird$(2); mv -f birdc birdc$(2); mv -f birdcl birdcl$(2) )
	-$(MAKE) -C $(PKG_BUILD_DIR) clean
	touch $$@

$(STAMP_BUILT): $(STAMP_BUILT)-$(2)

define Package/bird$(2)/install
	$(INSTALL_DIR)  $$(1)/usr/sbin
	$(INSTALL_BIN)  $$(PKG_BUILD_DIR)/bird$(2) $$(1)/usr/sbin/
	$(INSTALL_DIR)  $$(1)/etc
	$(INSTALL_DATA) ./files/bird$(2).conf $$(1)/etc/
	$(INSTALL_DIR)  $$(1)/etc/init.d
	$(INSTALL_BIN)  ./files/bird$(2).init $$(1)/etc/init.d/bird$(2)

endef

define Package/bird$(2)/conffiles
/etc/bird$(2).conf
endef

define Package/birdc$(2)/install
	$(INSTALL_DIR) $$(1)/usr/sbin
	$(INSTALL_BIN) $$(PKG_BUILD_DIR)/birdc$(2) $$(1)/usr/sbin/
endef

define Package/birdcl$(2)/install
	$(INSTALL_DIR) $$(1)/usr/sbin
	$(INSTALL_BIN) $$(PKG_BUILD_DIR)/birdcl$(2) $$(1)/usr/sbin/
endef

endef


$(eval $(call Build/Template,bird4,4, --disable-ipv6))
$(eval $(call Build/Template,bird6,6, --enable-ipv6))

$(eval $(call BuildPackage,bird4))
$(eval $(call BuildPackage,birdc4))
$(eval $(call BuildPackage,birdcl4))
$(eval $(call BuildPackage,bird6))
$(eval $(call BuildPackage,birdc6))
$(eval $(call BuildPackage,birdcl6))
