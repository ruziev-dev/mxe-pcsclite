# This file is part of MXE.
# See index.html for further information.

PKG             := libpcsclite
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.4.0
$(PKG)_CHECKSUM := 22307017a99e123dbecb991136783beca07966f1376d74d9ad0004ba5f81c4f1
$(PKG)_SUBDIR   := pcsc-lite-$($(PKG)_VERSION)
$(PKG)_FILE     := pcsc-lite-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://pcsclite.apdu.fr/files/$($(PKG)_FILE)
$(PKG)_DEPS     := cc



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