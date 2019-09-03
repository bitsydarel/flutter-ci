#!/bin/sh

## maintainer Darel Bitsy <bitsydarel@gmail.com>

# I assume that you're running this script from a macos computer with brew installed.

# Install virtual box
brew cask install virtualbox

# Create a vm with name of osx_sierra and os type mac os sierra
VBoxManage createvm --name osx_sierra --ostype MacOS1013_64 --register

VBoxManage modifyvm osx_sierra --bridgeadapter1 enp2s0
VBoxManage modifyvm osx_sierra --nic1 bridged

VBoxManage modifyvm osx_sierra --memory 4028

# Create hard drive for virtual machine
VBoxManage createhd --filename ~/VirtualBox\ VMs/osx_sierra/osx_sierra.vdi --size 35000 --format VDI

# Add sata controller
VBoxManage storagectl osx_sierra --name "SATA Controller" --add sata --controller IntelAhci

# Attach sata controller to the virtual machine disk
VBoxManage storageattach osx_sierra --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/osx_sierra/osx_sierra.vdi

VBoxManage modifyvm osx_sierra --cpus 2

VBoxManage modifyvm osx_sierra --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff

VBoxManage setextradata osx_sierra "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"

VBoxManage setextradata osx_sierra "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"

VBoxManage setextradata osx_sierra "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"

VBoxManage setextradata osx_sierra "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"

VBoxManage setextradata osx_sierra "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

VBoxManage modifyvm osx_sierra --vram 256

VBoxManage storageattach osx_sierra --storagectl IDE --port 1 --device 0 --type dvddrive --medium "/Users/user/Downloads/mojave.iso"

VBoxManage startvm osx_sierra
