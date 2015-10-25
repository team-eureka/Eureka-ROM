#!/bin/bash
set -e

# Vars
# Do NOT change these, as they affect the update engine!
Revision="$1"
VersionName="EurekaROM-$2.$Revision"

# Prefixed log messages are easier to distinguish
pLog() {
	echo "$VersionName: $1"
}

pLog "Extracting System"
unsquashfs ./system.img

# Start file modification.
pLog "Mounting System Partition"
ROOTFS="./squashfs-root"

# Set build revision
pLog "Setting Build Revision"
echo "$Revision" > "${ROOTFS}/etc/chromecast-ota.rev"

# Replace boot animation
pLog "Replacing Recovery"
cp -R ./recovery.img "${ROOTFS}/boot/recovery.img"

# Replace boot animation
pLog "Replacing Boot Animation"
cp -R ./basefiles/misc/boot-animation/* "${ROOTFS}/res/images/"

# No updating for you, also setup custom OTA system
pLog "Disabling OTA Updates & Enabling Eureka OTA Updates"
rm "${ROOTFS}/chrome/update_engine"
cp ./basefiles/bin/update_engine "${ROOTFS}/chrome/"
mkdir -p "${ROOTFS}/usr/share/eureka-apps/ota/"
cp ./basefiles/bin/chromecast-ota "${ROOTFS}/usr/share/eureka-apps/ota/"

# Change Hard Coded DNS Servers
pLog "Enabling use DHCP DNS Servers"
rm "${ROOTFS}/etc/dhcpcd/dhcpcd-hooks/20-dns.conf"
cp ./basefiles/misc/20-dns.conf "${ROOTFS}/etc/dhcpcd/dhcpcd-hooks/"

# Enable use of local CGI whitelist program
pLog "Enabling Team Eureka's Whitelisting Service"
sed -i 's|https://clients3.google.com/cast/chromecast/device/baseconfig|http://localhost/google-why-are-you-being-so-evilzz-whitelist|g' "${ROOTFS}/chrome/cast_shell"
sed -i 's|https://clients3.google.com/cast/chromecast/device/app|http://localhost/google-we-love-you-really-stay-awesom|g' "${ROOTFS}/chrome/cast_shell"
mkdir -p "${ROOTFS}/usr/share/eureka-apps/configs/"
cp ./basefiles/misc/apps.conf "${ROOTFS}/usr/share/eureka-apps/configs/"


# Disable googles idle screen restriction
pLog "Disabling idlescreen URL restriction"
sed -i 's|https://\*.google.com\;|\*\;\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00|g' "${ROOTFS}/chrome/cast_shell"

# Upload binaries
pLog "Adding BusyBox Tools, ADB, CURL, FTS-Utils and SSH Binaries"
cp -R ./basefiles/bin/busybox "${ROOTFS}/bin/"
cp -R ./basefiles/bin/adbd "${ROOTFS}/bin/"
cp -R ./basefiles/bin/curl "${ROOTFS}/bin/"
cp -R ./basefiles/bin/dropbear "${ROOTFS}/bin/"
cp -R ./basefiles/bin/dropbearkey "${ROOTFS}/bin/"
cp -R ./basefiles/bin/fts-get "${ROOTFS}/bin/"
cp -R ./basefiles/bin/fts-set "${ROOTFS}/bin/"

# Upload httpd binaries
pLog "Adding lighttpd, required modules, and creating root www folder"
cp -R ./basefiles/bin/lighttpd-angel "${ROOTFS}/usr/bin/"

cp -R ./basefiles/bin/lighttpd "${ROOTFS}/usr/bin/"
cp -R ./basefiles/misc/httpd.conf "${ROOTFS}/etc/"
cp -R ./basefiles/bin/lib "${ROOTFS}/usr/"
mkdir "${ROOTFS}/usr/share/www/"
cp -R ./basefiles/misc/www/* "${ROOTFS}/usr/share/www/"

# Upload EurekaSettings
pLog "Adding EurekaSettings"
cp ./basefiles/bin/EurekaSettings "${ROOTFS}/usr/bin/"
cp ./basefiles/misc/eureka.ini "${ROOTFS}/usr/share/eureka-apps/configs/"
chmod 777 "${ROOTFS}/usr/share/eureka-apps/configs/eureka.ini"

# Upload Whitelist-CGI
pLog "Adding Whitelist-CGI Application and whitelist-sync"
mkdir -p "${ROOTFS}/usr/share/cgi-apps/whitelist-cgi/"
cp ./basefiles/bin/Whitelist-CGI "${ROOTFS}/usr/share/cgi-apps/whitelist-cgi/index.cgi"
mkdir "${ROOTFS}/usr/share/eureka-apps/whitelist-sync/"
cp ./basefiles/bin/whitelist-sync "${ROOTFS}/usr/share/eureka-apps/whitelist-sync/whitelist-sync"

# Enable Telnet + ADB
pLog "Enabling Services at Startup"
rm "${ROOTFS}/bin/sntpd"
cp ./basefiles/bin/sntpd "${ROOTFS}/bin/sntpd"

pLog "Creating Release..."
mksquashfs ./squashfs-root/ system-eureka-release.img

pLog "Cleaning Up..."
rm -r ./squashfs-root/

# One final goodbye
pLog "Script Finished!"
