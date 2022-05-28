#!/bin/bash
echo "setting timezone to india"
timedatectl set-timezone Asia/Kolkata
echo "setting keyboard layout to us"
loadkeys /usr/share/kbd/keymaps/i386/qwerty/us.map.gz
lsblk
echo "Assuming you have created partition, now let's format the partition types"
echo
read -p "Press enter to continue"
echo "enter root path"
read root
echo
echo "enter home path"
read home
echo
echo "enter swap path"
read swap
echo
echo "formating....."
mkfs.ext4 $root
mkfs.ext4 $home
mkswap $swap
swapon $swap
echo "done!"
echo
echo "mounting....."
mount $root /mnt
mkdir /mnt/home
mount $home /mnt/home
echo "done!"
echo
lsblk
read -p "Press enter to continue"
echo "mirror setup"
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
pacman -Sy
pacman -S pacman-contrib
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist
echo "done!"
echo
echo "pacstrap"
pacstrap -i /mnt base base-devel linux linux-lts linux-headers linux-firmware sudo nano neofetch networkmanager dhcpcd pulseaudio amd-ucode/intel-ucode bluez wpa_supplicant
echo "done"
echo
echo "generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab
echo "type: arch-chroot /mnt"
