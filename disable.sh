#!/bin/bash
if lsof /var/lib/dpkg/lock &>/dev/null; then
    exit 0
fi
echo 1 > /sys/bus/pci/rescan
lspci | grep -i "3d controller" | cut -f 1 -d ' ' | while read pci ; do
    module=$(basename $(readlink /sys/bus/pci/devices/0000:${pci}/driver/module))
    echo "Disabled: $module (${pci})"
    rmmod -f $module
    echo 1 > /sys/bus/pci/devices/0000:${pci}/remove
done
udevadm control --reload
