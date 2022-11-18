#!/bin/bash
# author Jonathan Sanfilippo
# installazione di recovery parte seconda chroot

localhost="arch"
user="jonathan"
rootpw="password"
userpw="password"

ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime 
hwclock --systohc
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=it_IT.UTF-8.UTF-8" >> /etc/locale.conf
echo "KEYMAP=it" >> /etc/vconsole.conf  
echo "$localhost" > /etc/hostname
echo root:$rootpw | chpasswd
useradd -m $user
echo $user:$userpw | chpasswd
usermod -aG wheel $user
usermod -aG video $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
  

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








