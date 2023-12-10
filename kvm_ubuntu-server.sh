#!/bin/bash

vm_name="ubuntu22-04-server-template"


virt-install \
--name $vm_name \
--disk path=/PATH/TO/DISK/$vm_name.qcow2,size=40 \
--vcpus 2 \
--ram 4096 \
--os-variant ubuntu22.04 \
--network bridge=br0 \
--graphics spice \
--video qxl \
--channel spicevmc \
--console pty,target_type=serial \
--cdrom /PATH/TO/ISO_IMAGE/ubuntu-22.04.3-live-server-amd64.iso 
#--location 'https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso'
