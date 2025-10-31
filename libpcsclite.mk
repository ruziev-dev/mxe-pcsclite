# This file is part of MXE.
# See index.html for further information.

PKG             := libpcsclite
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.0
$(PKG)_CHECKSUM := 5544509999b3d5360f12b485aca69c48b43d875ac7ed1cb4afc2e33e49652abb
$(PKG)_SUBDIR   := pcsc-lite-$($(PKG)_VERSION)
$(PKG)_FILE     := pcsc-lite-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://pcsclite.apdu.fr/files/$($(PKG)_FILE)
$(PKG)_DEPS     := cc

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://pcsclite.apdu.fr/files/' | \
    $(SED) -n 's,.*pcsc-lite-\([0-9.]*\)\.tar.*,\1,p' | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --disable-libsystemd \
        --enable-static \
        --disable-shared
    $(MAKE) -C '$(1)' -j '$(JOBS)' \
        CFLAGS='-DWIN32'
    $(MAKE) -C '$(1)' -j 1 install
endef