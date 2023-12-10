#!/bin/bash

read -p "Enter a name for the new vm: " vm_name
read -p "Enter the absolute path where to save the disk image (omit the last '/'): " disk_image
read -p "Enter the vm disk size in GiB (e.g., 40): " disk_size
read -p "Enter the vCPUs quantity: " vcpus_value
read -p "Enter the ram quantity in MiB (e.g., 4096): " ram_value
read -p "Enter the OS distribution (e.g., ubuntu22.04): " os_value
echo "Network in bridge (br0) mode by default"

# Ask user about ISO file
read -p "Do you have an ISO file for installation? (Y/n): " has_iso

if [[ $has_iso =~ ^[Yy]$ || -z $has_iso ]]; then
    read -p "Enter the absolute path where the ISO image is located (include the .iso image): " iso_path
    cdrom_option="--cdrom $iso_path"
    location_option=""
else
    read -p "Enter the URL of the amd file: " iso_url
    cdrom_option=""
    location_option="--location '$iso_url'"
fi

# Run virt-install with the specified options
virt-install \
--name $vm_name \
--disk path=$disk_image/$vm_name.qcow2,size=$disk_size \
--vcpus $vcpus_value \
--ram $ram_value \
--os-variant $os_value \
--network bridge=br0 \
--graphics spice \
--video qxl \
--channel spicevmc \
--console pty,target_type=serial \
$cdrom_option \ 
$location_option
