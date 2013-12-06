BASE_BUILD = 14651
VERSION = 1
REVISION = 001
OTA_GIT_TAG = 1.2.1

BUILD_DIR = build
MOD_NAME = 20EurekaROM-$(BASE_BUILD)-V$(VERSION).zip
INSTALL = install

.PHONY: clean

$(MOD_NAME): \
	  $(BUILD_DIR)/images \
	  $(BUILD_DIR)/bin \
	  $(BUILD_DIR)/misc \
	  $(BUILD_DIR)/imager.sh
	rm -f $@
	cd $(BUILD_DIR) ; zip -r $(abspath $@) .
	echo "$$(md5sum $@ | cut -f1 -d' ')  /cache/eureka_image.zip" >$@.md5

clean:
	rm -rf $(BUILD_DIR) $(MOD_NAME) source/imager.sh source/boot-animation

$(BUILD_DIR)/images: \
	  download/ota/system.img \
	  download/ota/boot.img \
	  prebuilt/recovery.img
	$(INSTALL) -d $@
	$(INSTALL) -m 644 $? $@

$(BUILD_DIR)/bin: \
	  download/ChromeCast-OTA/chromecast-ota \
	  prebuilt/EurekaSettings \
	  prebuilt/adbd \
	  prebuilt/busybox \
	  prebuilt/curl \
	  prebuilt/dropbear \
	  prebuilt/lighttpd \
	  prebuilt/lighttpd-angel \
	  prebuilt/Whitelist-CGI \
	  prebuilt/whitelist-sync \
	  source/update_engine \
	  source/sntpd
	$(INSTALL) -d $@
	$(INSTALL) -d $(BUILD_DIR)/bin/lib
	$(INSTALL) prebuilt/lighttpd-libs/* -t $(BUILD_DIR)/bin/lib
	$(INSTALL) -m 755 $? $@

$(BUILD_DIR)/misc: \
	  source/boot-animation \
	  source/apps.conf \
	  source/httpd.conf \
	  source/eureka.ini \
	  source/20-dns.conf
	$(INSTALL) -d $@
	cp -r --no-preserve=timestamps $? $@

$(BUILD_DIR)/imager.sh: source/imager.sh
	$(INSTALL) -m 755 $< $@

download/ota/%: download/ota.zip | download
	unzip -DD $< $(notdir $@) -d $(@D)

download/ota.zip: | download
	curl -Lo $@ http://cache.pack.google.com/edgedl/googletv-eureka/stable-channel/ota.14651.stable-channel.eureka-b3.dfc8a782689cf97acc8d147b3eac1ab281486a4b.zip

download/ChromeCast-OTA/chromecast-ota: download/ChromeCast-OTA

download/ChromeCast-OTA: | download
	git clone -b $(OTA_GIT_TAG) https://github.com/team-eureka/ChromeCast-OTA.git $@

download:
	mkdir -p $@

source/boot-animation: source/boot-animation.mng
	rm -rf $@
	mkdir -p $@
	convert $< -resize 438x117 $@/logo1080p_10fps%04d.png
	convert $< -resize 292x78  $@/logo720p_10fps%04d.png
	convert $< -resize 195x52  $@/logo480p_10fps%04d.png

prebuilt/recovery.img:
	$(error Please place a prebuilt FlashCast recovery image at $@)

prebuilt/EurekaSettings:
	$(error Please place a compiled version of EurekaSettings at $@)
	
prebuilt/Whitelist-CGI:
	$(error Please place a compiled version of Whitelist-CGI at $@)	

prebuilt/whitelist-sync:
	$(error Please place the latest version of whitelist-sync at $@)	
	
IN_DEFINES = -e 's/@BASE_BUILD@/$(BASE_BUILD)/g' \
	     -e 's/@VERSION@/$(VERSION)/g' \
	     -e 's/@REVISION@/$(REVISION)/g'
%.sh: %.sh.in
	sed $(IN_DEFINES) $< >$@
