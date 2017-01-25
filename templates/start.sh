#!/bin/sh
bhyvectl --vm={{ item.name }} --destroy
#CentOS 6
#grub-bhyve -r hd0,msdos1 -m {{ bhyve_mountpoint}}/{{ item.name }}/device-installed.map -M {{ item.memory }} {{ item.name }} < {{ bhyve_mountpoint}}/{{ item.name }}/grub.installed > /dev/null
#CentOS 7
grub-bhyve -r hd0,msdos1 -m {{ bhyve_mountpoint}}/{{ item.name }}/device.installed.map -d /grub2 -M {{ item.memory }} {{ item.name }} -d /grub2 > /dev/null
b
bhyve -c {{ item.vcpu }} -m {{ item.memory }}M -H -P -A -l com1,stdio -s 0:0,hostbridge -s 1:0,lpc -s 2:0,virtio-net,{{ item.tap }} -s 3,ahci-cd,{{ item.iso }} -s 4,virtio-blk,/dev/zvol/{{ bhyve_dataset }}/{{ item.name }}//root -s 5,virtio-blk,/dev/zvol/{{ bhyve_dataset }}/{{ item.name }}/swap {{ item.name }}
