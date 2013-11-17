BASE_BUILD = 13300
VERSION = 1
OTA_GIT_TAG = V1.0

BUILD_DIR = build
MOD_NAME = 20PwnedCast-$(BASE_BUILD)-V$(VERSION).zip
INSTALL = install

.PHONY: clean

$(MOD_NAME): \
	  $(BUILD_DIR)/images \
	  $(BUILD_DIR)/bin \
	  $(BUILD_DIR)/misc \
	  $(BUILD_DIR)/imager.sh
	rm -f $@
	cd $(BUILD_DIR) ; zip -r $(abspath $@) .

clean:
	rm -rf $(BUILD_DIR) $(MOD_NAME)

$(BUILD_DIR)/images: \
	  download/ota/system.img \
	  download/ota/boot.img \
	  prebuilt/recovery.img
	$(INSTALL) -d $@
	$(INSTALL) -m 644 $? $@

$(BUILD_DIR)/bin: \
	  download/PwnedCast-OTA/pwnedcast-update.sh \
	  prebuilt/adbd \
	  prebuilt/busybox \
	  prebuilt/dropbear \
	  source/update_engine \
	  source/clear_crash_counter
	$(INSTALL) -d $@
	$(INSTALL) -m 755 $? $@

$(BUILD_DIR)/misc: \
	  prebuilt/boot-animation \
	  source/20-dns.conf
	$(INSTALL) -d $@
	cp -r --no-preserve=timestamps $? $@

$(BUILD_DIR)/imager.sh: source/imager.sh
	$(INSTALL) -m 755 $< $@

download/ota/%: download/ota.zip | download
	unzip -DD $< $(notdir $@) -d $(@D)

download/ota.zip: | download
	curl -Lo $@ http://cache.pack.google.com/edgedl/googletv-eureka/stable-channel/ota.13300.stable-channel.eureka-b3.1f63ef63d1f43c6222116806e5bea38a47e9f124.zip

download/PwnedCast-OTA/pwnedcast-update.sh: download/PwnedCast-OTA

download/PwnedCast-OTA: | download
	git clone -b $(OTA_GIT_TAG) https://github.com/riptidewave93/PwnedCast-OTA.git $@

download:
	mkdir -p $@

prebuilt/recovery.img:
	$(error Please place a prebuilt FlashCast recovery image at $@)
