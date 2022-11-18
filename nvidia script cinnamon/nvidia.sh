#!/bin/bash

pacman -S --noconfirm nvidia nvidia-utils nvidia-settings libva-mesa-driver libva-vdpau-driver libva-utils

  mkdir -p /etc/pacman.d/hooks
echo "[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'" > /etc/pacman.d/hooks/nvidia.hook

echo "blacklist nouveau" > /etc/modprobe.d/blacklist-nvidia-nouveau.conf

echo 'Section "OutputClass"
Identifier "intel"
MatchDriver "i915"
Driver "modesetting"
EndSection

Section "OutputClass"
Identifier "nvidia"
MatchDriver "nvidia-drm"
Driver "nvidia"
Option "AllowEmptyInitialConfiguration"
Option "PrimaryGPU" "yes"
ModulePath "/usr/lib/nvidia/xorg"
ModulePath "/usr/lib/xorg/modules"
EndSection' > /etc/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf


 cp -r mkinitcpio.conf /etc/
 

echo "xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto" > $HOME/.xinitrc

echo "#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto" > /etc/lightdm/display_setup.sh

chmod +x /etc/lightdm/display_setup.sh

echo "
[Seat:*]
display-setup-script=/etc/lightdm/display_setup.sh" >> /etc/lightdm/lightdm.conf

echo "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder
--enable-zero-copy
--disable-features=UseChromeOSDirectVideoDecoder" > $HOME/.config/chrome-flags.conf


