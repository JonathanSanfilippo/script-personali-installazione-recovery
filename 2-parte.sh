#!/bin/bash
# author Jonathan Sanfilippo
# installazione di recovery 

echo "arch" > /etc/hostname
echo root:nonlaso | chpasswd
useradd -m jonathan
echo jonathan:nonlaso | chpasswd
usermod -aG wheel jonathan
usermod -aG video jonathan
echo "jonathan ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/jonathan
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
  

pacman -S efibootmgr wpa_supplicant wireless_tools dialog netctl net-tools iw networkmanager
pacman -S pacman-contrib git wget jq tk gparted mtools dosfstools alsa-utils pipewire-pulse firewalld cronie bluez bluez-utils reflector  
#pacman -S gimp vlc conky 

#pacman -S sddm plasma ark konsole dolphin xorg 
pacman -S cinnamon nemo-fileroller gnome-terminal lightdm-gtk-greeter lightdm-gtk-greeter-settings
#pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings epiphany
#pacman -S gnome 


systemctl enable lightdm
#systemctl enable gdm
#systemctl enable sddm
systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable bluetooth
systemctl enable cronie
systemctl enable reflector.timer











