#!/bin/bash
# This script will configure the system with easy-effcts and pipewire audio

cat << _EOF_

        ==========================================================
	||	Ubuntu-Fresh-Tweaks     Version: 0.0.1		||
	||		Audio Tweaks for Ubuntu			||
	||		  ###EasyEffects###			||
	==========================================================

          This script will install some imporatant and essential
        packeges and will do some additional tweaks on this system.
         please connect the system to the internet before continue.

	 PRE-REQUIRIES : Flatpak must be installed on the system
	 		 An internet connections
			 
	      If you have not installed Flatpak on your system
	      please run the ubuntu-fresh-tweaks.sh and select
	    first option shown as 1) Essentials before continue.
_EOF_

echo "Do you want to continue:(y/N)"
read -n 1 -s choose
echo
sleep 2

if [[$choose!="y"]||[$choose!="Y"]]
then
	exit 1
fi

# Installing and configuring pipewire
sudo add-apt-repository ppa:pipewire-debian/pipewire-upstream -yy

sudo apt update -yy

sudo apt install pipewire -yy

sudo apt install gstreamer1.0-pipewire libspa-0.2-bluetooth libspa-0.2-jack -yy

# Installing linux studio plugins
sudo apt install lsp-plugins -yy

# Installing EasyEffest from flathub.org
flatpak install flathub com.github.wwmm.easyeffects

cat << _EOF_

	===========================================
	|| Installation successfully completed...||
	===========================================

_EOF_

echo "System changes will be affected after rebooting the system"
echo "Do you want to reboot the system now? (y/N)"
read -n 1 -s choose_r

if [$choose_r ="y"]||[$choose_r="Y"];
then
	reboot
else
	exit 2
fi
