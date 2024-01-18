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
    read -p "Enter the absolute path where the ISO files are located: " iso_directory

    # List available .iso files in the specified directory
    iso_files=("$iso_directory"/*.iso)

    if [ ${#iso_files[@]} -eq 0 ]; then
        echo "No .iso files found in the specified directory."
        exit 1
    fi

    echo "Available .iso files:"
    ls "$iso_directory"/*.iso

    # Prompt user to choose an .iso file
    read -p "Enter the name of the desired .iso file: " iso_file
    iso_path="$iso_directory/$iso_file"
    cdrom_option="--cdrom=$iso_path"
else
    read -p "Enter the URL of the amd file: " iso_url
    cdrom_option="--cdrom=$iso_url"
fi

# Run virt-install with the specified options
virt-install \
    --name $vm_name \
    --memory $ram_value \
    --vcpus $vcpus_value \
    --os-variant $os_value \
    --disk path=$disk_image/$vm_name.qcow2,size=$disk_size \
    --network bridge=br0 \
    --graphics spice \
    --video qxl \
    --channel spicevmc \
    --console pty,target_type=serial \
    $cdrom_option
