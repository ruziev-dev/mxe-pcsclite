# This file is part of MXE.
# See index.html for further information.

PKG             := libpcsclite
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.0
$(PKG)_SUBDIR   := pcsc-lite-$($(PKG)_VERSION)
$(PKG)_FILE     := pcsc-lite-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://pcsclite.apdu.fr/files/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

#wget -P /opt/mxe/pkg/ https://pcsclite.apdu.fr/files/pcsc-lite-2.4.0.tar.xz

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://pcsclite.apdu.fr/files/' | \
    $(SED) -n 's,.*pcsc-lite-\([0-9.]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
     cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        --disable-gtk-doc \
        --disable-man \
        --without-tools \
        --without-imagemagick
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' LDFLAGS='-no-undefined'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef