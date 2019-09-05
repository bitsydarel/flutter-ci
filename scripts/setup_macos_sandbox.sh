#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

## I assume that you're running this script from a macos computer with brew installed.
## I also assume that you have a installed virtualbox

# Change this to change the name of the virtual box machine name.
VIRTUAL_MACHINE_NAME="osx_mojave"

# Change this to change the installer location
# shellcheck disable=SC2089
MAC_OS_INSTALLER_LOCATION="/Applications/Install\ macOs\ Mojave.app"

# Delete vm if already exist.
VBoxManage unregister --delete $VIRTUAL_MACHINE_NAME

# Create a vm with name of osx_sierra and os type mac os sierra
VBoxManage createvm --name $VIRTUAL_MACHINE_NAME --ostype MacOS_64 --register

#VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --bridgeadapter1 enp2s0
VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --nic1 nat

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --memory 4028

# Create hard drive for virtual machine
VBoxManage createhd --filename ~/VirtualBox\ VMs/$VIRTUAL_MACHINE_NAME/$VIRTUAL_MACHINE_NAME.vdi --size 35000 --format VDI

# Add sata controller
VBoxManage storagectl $VIRTUAL_MACHINE_NAME --name "SATA Controller" --add sata --controller IntelAhci

# Attach sata controller to the virtual machine disk
VBoxManage storageattach $VIRTUAL_MACHINE_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/$VIRTUAL_MACHINE_NAME/$VIRTUAL_MACHINE_NAME.vdi

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --cpus 2

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --vram 256

wget -O /tmp/prepare-iso.sh https://raw.githubusercontent.com/bitsydarel/macos-virtualbox-vm/master/prepare-iso.sh && chmod +x /tmp/prepare-iso.sh

sudo sh /tmp/prepare-iso.sh $MAC_OS_INSTALLER_LOCATION "$VIRTUAL_MACHINE_NAME.iso"

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --audio none

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --usbxhci on

VBoxManage storagectl $VIRTUAL_MACHINE_NAME --name "IDE Controller" --add ide --controller PIIX4

VBoxManage storageattach $VIRTUAL_MACHINE_NAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$VIRTUAL_MACHINE_NAME.iso"

VBoxManage startvm $VIRTUAL_MACHINE_NAME
