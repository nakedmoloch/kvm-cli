# README.md
**Use case**: You may want to create the first virtual machine as a template for the following ones.

## kvm_template.sh

```sh
#!/bin/bash

vm_name="ubuntu22.04-server"

virt-install \
    --name $vm_name \
    --memory 4096 \
    --vcpus 2 \
    --os-variant ubuntu22.04 \
    --disk path=/PATH/TO/SAVE/DISK/$vm_name.qcow2,size=40 \
    --network bridge=br0 \
    --graphics spice \
    --video qxl \
    --channel spicevmc \
    --console pty,target_type=serial \
    
    #Choose one
    --cdrom /PATH/TO/ISO_FILE/ubuntu22.04.3-live-server.amd64.iso
    #--cdrom https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso
```
