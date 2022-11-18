#!/bin/bash
# author Jonathan Sanfilippo
# installazione di recovery 


#mkfs.fat -F32 /dev/sda1
#mkswap /dev/sda2
#mkfs.ext4 /dev/sda4
mkfs.btrfs -f /dev/sda3      
mount /dev/sda3 /mnt           
btrfs su cr /mnt/@              
btrfs su cr /mnt/@home      
umount /mnt                             
mount -o noatime,commit=120,compress=zstd,space_cache=v2,ssd,subvol=@ /dev/sda3 /mnt 
mkdir -p /mnt/{boot,home,iso} 
mount -o noatime,commit=120,compress=zstd,space_cache=v2,ssd,subvol=@home /dev/sda3 /mnt/home 
mount /dev/sda1 /mnt/boot 
swapon
mount /dev/sda4 /mnt/iso 

reflector --verbose -c gb -a 6  --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware vim 
genfstab -Up /mnt > /mnt/etc/fstab
cp 2-parte.sh /mnt/home/
arch-chroot /mnt 

