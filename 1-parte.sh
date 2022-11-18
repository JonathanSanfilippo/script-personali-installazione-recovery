#!/bin/bash
# author Jonathan Sanfilippo
# installazione di recovery per il sistema Arch Linux

#nvme
#p1="/dev/nvme0n1p1"
#p2="/dev/nvme0n1p2"
#p3="/dev/nvme0n1p3"
#p4="/dev/nvme0n1p4"
#p5="/dev/nvme0n1p5"

#ssd
p1="/dev/sda1"
p2="/dev/sda2"
p3="/dev/sda3"
p4="/dev/sda4"
p5="/dev/sda5"

c="gb,nl"

#Formattazione delle partizioni
#mkfs.fat -F32 $p1
#mkswap  $p2
#mkfs.ext4  $p4
#mkfs.ext4  $p5
mkfs.btrfs -f $p3      

#Montaggio e sottovolumi
mount $p3 /mnt           
btrfs su cr /mnt/@              
btrfs su cr /mnt/@home      
umount /mnt                             
mount -o noatime,commit=120,compress=zstd,space_cache=v2,ssd,subvol=@ $p3 /mnt 
mkdir -p /mnt/{boot,home,iso,scripts} 
mount -o noatime,commit=120,compress=zstd,space_cache=v2,ssd,subvol=@home $p3 /mnt/home 
mount $p1 /mnt/boot 
swapon
mount $p4 /mnt/iso 
#mount $p5 /mnt/scripts 

reflector --verbose -c $c -a 6  --sort rate --save /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware vim 
genfstab -Up /mnt > /mnt/etc/fstab
cp 2-parte.sh /mnt/home/
arch-chroot /mnt 

