Eureka-ROM is EOL'ed
=============

Team Eureka has moved to [ROM] Flashcast-AutoRoot, with ssh, adb, and OTA w/ root support but no webpage, will keep you up to date with Chrome OTA and root

http://forum.xda-developers.com/android-tv/chromecast/rom-flashcast-autoroot-t3270332

=============

This is the source scripts used to build Eureka-ROM

Note that the building of the custom kernel is NOT AUTOMATED, and a quick rundown of the process can be found in `./initramfs/README.md`

Building Minimal Image
---

1. Extract system.img from official OTA and place at `./system.img`
2. Place your custom recovery image at `./recovery.img`
3. Create a minimal image using `./02make-minimal.sh`
4. At this point you now have a Minimal System image named `system-minimal.img` that can be flashed with the stock kernel from the official OTA to keep persistant root.


Building Eureka-ROM
---

1. Extract system.img from official OTA and place at `./system.img`
2. Place your custom recovery image at `./recovery.img`
3. Create the Eureka-ROM system image using `./03make-release.sh 001 34343` where `001` is the revision, and `34343` is the OTA build number.
4. At this point you now have a Eureka-ROM System image named `system-eureka-release.img`
5. Follow `./initramfs/README.md` to build your custom Kernel
