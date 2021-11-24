#!/bin/bash

cat << _EOF_
		Ubuntu-Fresh-Tweaks	Version: 0.0.1

	  This script will install some imporatant and essential
	packeges and will do some additional tweaks on this system.
      	 please connect the system to the internet before continue.

_EOF_

echo "press any key to continue"
read -n 1 -s
clear

cat << _EOF_

Please select one of following category: 
(More informations about installation packages can be found on
README.md file.)
	
		1) Essential Tweaks only.
		2) Install software packages for home use.
		3) Inatall software packages for Student Computer.
		4) Install software packeges for Developer System.

_EOF_

read -n 1 -s choose_C
clear

# Software packeges

brave_browser(){
	sudo apt install apt-transport-https curl -yy

	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update -yy

	sudo apt install brave-browser -yy
}

chromium_browser(){
	sudo apt install chromium-browser
}

vs_code(){
	wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
	sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
	sudo apt install code
}

python(){
	sudo apt-get install python3 python3-venv python3-pip
}

# Selecting softwares
#
sel_browser(){
	# Select a browser and install it
cat << _EOF_
Select your choise of browser:
	1) Brave Browser (A private secure browser)
	2) Chromium Browser (The chrome without google)
_EOF_

echo "Please select one browser:"
read -n 1 -s choose_browser
clear

case $choose_browser in
	1)
		brave_browser; sleep 3;;
	2)
		chromium_browser; sleep 3;;
esac
}

#Installation steps
#
first_step(){

	# Update the system
	echo
	echo "First things fisrt, we are checking for new updates..."
	echo 
	sudo apt update && sudo apt upgrade -yy

	cat << _EOF_
	==============================
	# System successfuly updated #
	==============================
_EOF_
}

essentials(){
	sudo apt install ubuntu-restricted-extras grub-customizer synaptic bleachbit build-essential software-properties-common apt-transport-https wget -yy

	#installing and configurings flatpak
	sudo apt install flatpak -yy
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

home_use(){
	#installing few softwares that needs for daily life
	sudo apt install vlc gimp -yy

	
	# Some additional terminal tools
	sudo apt install neovim
	sudo snap install bat lsd
}

student(){
	essentials
	home_use
	vs_code
 
}

developer(){
	student
}

final_step(){
	sudo apt autoremove
}


case $choose_C in
	1)
		first_step; sleep 3 ; essentials; sleep 3; final_step;;
	2)
		sel_browser; first_step; sleep 3; home_use; sleep 3; final_step;;
	3)
		sel_browser; first_step; sleep 3; student; sleep 3; final_step;;
	4)
		sel_browser; first_step; sleep 3; developer; sleep 3; final_step;;
	esac


cat << _EOF_

	===================================
	# Opertaion Successfuly Completed #
	===================================

_EOF_

