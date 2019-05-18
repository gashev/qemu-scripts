#!/bin/bash

printf -v macaddr "52:54:%02x:%02x:%02x:%02x" $(( $RANDOM & 0xff)) $(( $RANDOM & 0xff )) $(( $RANDOM & 0xff)) $(( $RANDOM & 0xff ))

tap_device_name=$(uuidgen |tr -d '-')
nohup /opt/qemu/bin/qemu-system-x86_64 -enable-kvm -machine q35,accel=kvm -cpu host -hda "${1}" -device intel-iommu  -device virtio-net,netdev=network0,mac=$macaddr -netdev tap,id=network0,ifname=tap${tap_device_name},script=./qemu-ifup,downscript=./qemu-ifdown -m 4096 &
