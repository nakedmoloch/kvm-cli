# README.md

## kvm_template.sh

```sh
#!/bin/bash

#Choose a name
vm_name="<your_vm_name>"


virt-install \
--name $vm_name \
--disk path=/PATH/TO/SAVE/DISK/$vm_name.qcow2,size=<your_vm_size(in GiB)> \
--vcpus <your_vm_vcpus> \
--ram <your_vm_ram(in MiB)> \

#Set the apropriate OS. Example: ubuntu22.04
--os-variant <your_vm_distro_and_version> \

#Assuming using bridged network
--network bridge=br0 \

--graphics spice \
--video qxl \
--channel spicevmc \
--console pty,target_type=serial \

#Choose one:
--cdrom /PATH/TO/ISO_IMAGE/<your_vm_distro_iso> 
#--location '<your_vm_distro_http_download_link>'
```
