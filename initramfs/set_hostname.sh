#!/bin/sh

# Pull hostname from config, format, and set using dhcpcd
Hostname=$(/usr/bin/EurekaSettings get EurekaRom hostname | busybox tr ' ' '-' | busybox tr '_' '-')

# Set in kernel
echo $Hostname > /proc/sys/kernel/hostname

# Set vi dhcp
/bin/dhcpcd mlan0 eth0 -B --noarp -h $Hostname
