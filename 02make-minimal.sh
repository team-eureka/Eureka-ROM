#!/bin/bash

unsquashfs ./system.img
rm ./squashfs-root/boot/recovery.img
cp ./recovery.img ./squashfs-root/boot/recovery.img
rm ./squashfs-root/chrome/update_engine
cp ./basefiles/bin/update_engine ./squashfs-root/chrome/update_engine
mksquashfs ./squashfs-root/ system-minimal.img
rm -r ./squashfs-root/