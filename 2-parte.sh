#!/bin/bash
# author Jonathan Sanfilippo
# installazione di recovery parte seconda chroot
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

localhost="arch"
user="jonathan"
rootpw="password"
userpw="password"
localegen="en_US.UTF-8 UTF-8"
localeconf="LANG=en_US.UTF-8.UTF-8"
km="us"
localtime="Europe/London"

ln -sf /usr/share/zoneinfo/$localtime /etc/localtime 
hwclock --systohc
echo "$localegen" > /etc/locale.gen
locale-gen
echo "$localeconf" >> /etc/locale.conf
echo "KEYMAP=$km" >> /etc/vconsole.conf  
echo "$localhost" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1       localhost" >> /etc/hosts
echo root:$rootpw | chpasswd
useradd -m $user
echo $user:$userpw | chpasswd
usermod -aG wheel $user
usermod -aG video $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
  


#systemd-boot
bootctl --path=/boot install
echo "default arch-*" >> /boot/loader/loader.conf
echo "timeout 3" >> /boot/loader/loader.conf
echo "title Hey! Select me.. :)
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=/dev/$p3 rootflags=subvol=@ rw quite loglevel=3 rd.system.show_status=auto rd.udev.log_level=3" > /boot/loader/entries/arch.conf
echo "title Recovery ISO
linux /live/vmlinuz-linux
initrd /live/initramfs-linux.img
options img_dev=/dev/$p4 img_loop=archlinux.iso copytoram rw" > /boot/loader/entries/live.conf

mkinitcpio -P




pacman -S efibootmgr wpa_supplicant wireless_tools dialog netctl net-tools iw networkmanager 
pacman -S pacman-contrib git wget jq tk gparted mtools dosfstools alsa-utils pipewire-pulse firewalld cronie bluez bluez-utils reflector  acpi ltp 

#Ambienti desktop
#pacman -S sddm plasma ark konsole dolphin xorg 
pacman -S cinnamon nemo-fileroller gnome-terminal lightdm-gtk-greeter lightdm-gtk-greeter-settings xdg-user-dirs-gtk
#pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings epiphany
#pacman -S gnome 

#display manager
systemctl enable lightdm
#systemctl enable gdm
#systemctl enable sddm

#servizi
systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable bluetooth
systemctl enable cronie
systemctl enable reflector.timer


rm -r /home/2-parte.sh








