#!/bin/bash

#clear the current terminal
clear

# Declare variables
ansy=y
ansY=Y

cat <<_EOF_
		Ubuntu-Fresh-Tweaks	Version: 0.0.1

	  This script will install some imporatant and essential
	packeges and will do some additional tweaks on this system.
      	 please connect the system to the internet before continue.

_EOF_

echo "press any key to continue"
read -r -n 1 -s
clear

cat <<_EOF_

Please select one of following category: 
(More informations about installation packages can be found on
README.md file.)
	
		1) Essential Tweaks only.
		2) Cruiserweight.
		3) Average.
		4) Heavyweight.

_EOF_

read -r -n 1 -s choose_C
clear

# Software packeges

# Cannonical snap support for snap disabled Debian/ Ubuntu based systems
snap_support() {
	clear
	echo "Do you want to configure Canonical Snap on yor system? (y/N)"
	read -n 1 -s sel_snap
	echo

	ansy=y
	ansY=Y

	case $sel_snap in
	y)
		sudo apt-get install snapd
		;;

	Y)
		sudo apt-get install snapd
		;;

	esac

}

# Brave Browser
brave_browser() {
	sudo apt install apt-transport-https curl -yy

	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update -yy

	sudo apt install brave-browser -yy
}

# Chromium Browser
chromium_browser() {
	sudo apt install chromium-browser
}

# Microsoft visual studio code
vs_code() {
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install code
}

# Python 3
python() {
	sudo apt-get install python3 python3-venv python3-pip
}

# TLP and Auto-cpufreq for laptops
laptop_battery() {
	sudo apt install tlp -yy
	sudo snap install auto-cpufreq
	sudo systemctl enable snap.auto-cpufreq.service.service
	systemctl start snap.auto-cpufreq.service.service

}

# Selecting softwares
#
sel_browser() {
	# Select a browser and install it
	cat <<_EOF_
Select your choise of browser:
	1) Brave Browser (A private secure browser)
	2) Chromium Browser (The chrome without google)
	3) Do not install any browser
_EOF_

	echo "Please select one browser:"
	read -r -n 1 -s choose_browser
	clear

	case $choose_browser in
	1)
		brave_browser
		sleep 3
		;;
	2)
		chromium_browser
		sleep 3
		;;

	3)
		continue
		;;

	esac
}

sel_laptop() {
	laptop=2
	clear
	cat <<_EOF_
There are some recommended tweaks for laptop computers.
Do you want to install them on this computer?
		1) Yes
		2) No

_EOF_
	echo "Default: (2)"
	read -r -n 1 -s laptop
	clear

	case $laptop in
	1)
		laptop_battery
		;;
	2)
		continue
		;;
	esac
}
#Installation steps
#
first_step() {

	# Update the system
	echo
	echo "First things fisrt, we are checking for new updates..."
	echo
	sudo apt update && sudo apt upgrade -yy

	cat <<_EOF_
	==============================
	# System successfuly updated #
	==============================
_EOF_

	sleep 1
}

essentials() {
	first_step
	snap_support
	sel_laptop
	sudo apt install git ubuntu-restricted-extras grub-customizer synaptic bleachbit build-essential software-properties-common apt-transport-https wget -yy

	#installing and configurings flatpak
	sudo apt install flatpak -yy
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

cruiserweight() {
	#installing few softwares that needs for daily life
	essentials
	sel_browser
	sudo apt install vlc gimp -yy

	# Some additional terminal tools
	sudo apt install neovim bat
	sudo snap install lsd
}

average() {
	cruiserweight
	vs_code

	# Install starship. A cross platfor shell prompt.
	sudo snap install starship
	sleep 1
	clear
	cat <<_EOF_
NOTICE !!!

Starship cross-platform shell prompt was installed.
Please visit starship.rs to see how to configure
your shell to use starship.

_EOF_
	sleep 3
}

heavyweight() {
	student
	sudo apt install kitty

	#install zsh with powerline10k theme
	sudo apt install zsh
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
	echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
}

final_step() {
	sudo apt autoremove
}

case $choose_C in
1)

	sleep 3
	essentials
	sleep 3
	final_step
	;;
2)

	sleep 3
	cruiserweight
	sleep 3
	final_step
	;;
3)
	sleep 3
	average
	sleep 3
	final_step
	;;
4)
	sleep 3
	heavyweight
	sleep 3
	final_step
	;;
esac

cat <<_EOF_

	===================================
	# Opertaion Successfuly Completed #
	===================================

_EOF_

echo "Do you want to restart the system now?"
read -r -n 1 -s choose_restart

case $choose_restart in
y)
	reboot
	;;
Y)
	reboot
	;;
esac
