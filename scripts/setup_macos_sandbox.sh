#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

## I assume that you're running this script from a macos computer with brew installed.
## I also assume that you have a installed virtualbox

# Change this to change the name of the virtual box machine name.
VIRTUAL_MACHINE_NAME="osx_mojave"

# Change this to change the installer location
# shellcheck disable=SC2089
MAC_OS_INSTALLER_LOCATION="/Applications/Install\ macOs\ Mojave.app"

MAC_OS_INSTALLER_ISO=""

getIsoFileName()
{
  if [ -f "Mojave.iso" ]; then
      MAC_OS_INSTALLER_ISO="Mojave.iso"
  elif [ -f "HighSierra.iso" ]; then
      MAC_OS_INSTALLER_ISO="HighSierra"
  elif [ -f "Sierra" ]; then
      MAC_OS_INSTALLER_ISO="Sierra"
  elif [ -f "ElCapitan.iso" ]; then
      MAC_OS_INSTALLER_ISO="ElCapitan"
  elif [ -f "Yosemite.iso" ]; then
      MAC_OS_INSTALLER_ISO="Yosemite"
  fi
}

# Delete vm if already exist.
VBoxManage unregistervm --delete $VIRTUAL_MACHINE_NAME

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

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemFamily" "MacBook Pro"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacBookPro11,2"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemUuid" "CAFECAFE-CAFE-CAFE-CAFE-DECAFFDECAFF"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemVendor" "Apple Inc."

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial" "C02LJ6QSFD56"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiOEMVBoxVer" "string:1"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiOEMVBoxRev" "string:.23456"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiBIOSVersion" "string:MBP7.89"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-3CBD00234E554E41"

VBoxManage setextradata "El_Capitan" "VBoxInternal/Devices/efi/0/Config/DmiBoardSerial" "C02LJ6QSFDW1A"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0000/Uuid" "4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0000/Name" "MLB"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0000/Value" "bytes:$(echo -n "C02LJ6QSFDW1A" | base64)"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0001/Uuid" "4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0001/Name" "ROM"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0001/Value" "%aa*%bbg%cc%dd"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0002/Uuid" "7C436110-AB2A-4BBB-A880-FE41995C9F82"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0002/Name" "system-id"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0002/Value" "aabbccddeeff00112233445566778899"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0003/Uuid" "7C436110-AB2A-4BBB-A880-FE41995C9F82"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0003/Name" "csr-active-config"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/efi/0/LUN#0/Config/Vars/0003/Value" "0x10"

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 0

VBoxManage setextradata $VIRTUAL_MACHINE_NAME "VBoxInternal2/EfiGraphicsResolution" "1280x800"

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --vram 256

wget -O /tmp/prepare-iso.sh https://raw.githubusercontent.com/bitsydarel/macos-virtualbox-vm/master/prepare-iso.sh && chmod +x /tmp/prepare-iso.sh

sudo sh /tmp/prepare-iso.sh MAC_OS_INSTALLER_LOCATION "$VIRTUAL_MACHINE_NAME.iso"

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --audio none

VBoxManage modifyvm $VIRTUAL_MACHINE_NAME --usbxhci on

VBoxManage storagectl $VIRTUAL_MACHINE_NAME --name "IDE Controller" --add ide --controller PIIX4

getIsoFileName

VBoxManage storageattach $VIRTUAL_MACHINE_NAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $MAC_OS_INSTALLER_ISO

VBoxManage startvm $VIRTUAL_MACHINE_NAME
