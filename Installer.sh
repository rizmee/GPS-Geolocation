#!/bin/bash
# ORIGINAL CREATOR: Luca Garofalo (Lucksi)
# AUTHOR: Luca Garofalo (Lucksi)
# Copyright (C) 2021-2023 Lucksi <lukege287@gmail.com>
# License: GNU General Public License v3.0

ARCHITECTURE="$(arch)"
YELLOW=$(tput setaf 11)
RED=$(tput setaf 1)
WHITE=$(tput setaf 15)

function Banner {
	banner=$(<"Banner/Banner2.txt")
	printf "${YELLOW}$banner"
}

function Ngrok {
	printf "\n\n${WHITE}OS ARCHITECTURE DETCTED:$ARCH"
    if [[ ${ARCHITECTURE} == "x86_64" || ${ARCHITECTURE} == "x86_64" ]];
		then
		wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip &> /dev/null | printf "${WHITE}\n\nINSTALLING NGROK 64 BIT"
	else
		wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-i386.zip &> /dev/null | printf "${WHITE}\n\nINSTALLING NGROK 32 BIT"
	fi
	unzip ngrok.zip &> /dev/null | printf "\n\n${WHITE}SETTING UP NGROK"
	mv ngrok Tunnel
	rm ngrok.zip
	printf "\n\n${WHITE}NGROK INSTALLED SUCCESSFULLY"
	printf "\n\n${WHITE}INSERT YOUR NGROK AUTHTOKEN(REQUIRED)\n\n"
	read -p"$YELLOW[INTERCEPTOR]$WHITE-->" token
	while [ "$token" = "" ];
		do
        printf "\n\n${WHITE}INSERT YOUR NGROK AUTHTOKEN(REQUIRED)\n\n"
        read -p"$YELLOW[INTERCEPTOR]$WHITE-->" token
	done
	printf "\n\n${WHITE}CONFIGURING NGROK AUTHTOKEN..."
	ngrok authtoken $token
	sleep 3
	printf "\n\n${WHITE}NGROK CONFIGURED SUCCESSFULLY"

}

function Configuration {
	Fold=${PWD##*/}
    cd Configuration
	echo ";CHANGE THESE VALUE IF YOU WANT TO UPDATE YOUR SETTINGS FROM HERE">Configuration.ini
	echo ";BUT DO NOT CHANGE THE PARAMETERS NAME">>Configuration.ini
	echo "">>Configuration.ini		
	echo "[Settings]">>Configuration.ini
	echo "Password = $passw">>Configuration.ini
	rm UNTILED.txt &> /dev/null
	cd ../
	cd Database
	rm UNTILED.txt
	cd ../
	sleep 3
	printf "\n\n${WHITE}FILES CREATED SUCCESSFULLY"
	sleep 2		
	chmod +x Interceptor.sh &> /dev/null | printf "${WHITE}\n\nCONFIGURING INTERCEPTOR"
	cd ../
	echo "Path = `pwd`">>$Fold/Configuration/Configuration.ini
}

function installer {
    apt-get install php -y &> /dev/null | printf "${WHITE}\n\nINSTALLING PHP"
    apt-get install curl -y &> /dev/null | printf "${WHITE}\n\nINSTALLING CURL"
    apt-get install wget -y &> /dev/null | printf "${WHITE}\n\nINSTALLING WGET"
    apt-get install grep -y &> /dev/null | printf "${WHITE}\n\nINSTALLING GREP"
	apt-get install snapd  -y &> /dev/null | printf "${WHITE}\n\nINSTALLING SNAPD"
	snap install ngrok &> /dev/null | printf "${WHITE}\n\nINSTALLING REQUIREMENTS FOR NGROK"
	printf "${WHITE}\n\nCHECKING YOUR OS ARCHITECTURE..."
	sleep 2
	Ngrok
	printf "${WHITE}\n\nINSERT YOUR UPDATE PASSWORD\n\n"
	read -sp"$YELLOW[INTERCEPTOR]$WHITE-->" passw
	while [ "$passw" = "" ];
		do
        printf "${WHITE}\n\nINSERT YOUR UPDATE PASSWORD \n\n"
        read -sp"$YELLOW[INTERCEPTOR]$WHITE-->" passw
	done
	printf "$WHITE\n\nCREATING CONFIGURATION FILE"
    Configuration
	sleep 1
	printf "$\n\n${WHITE}PROGRAM INSTALLED CORRECTLY"
	printf "${YELLOW}\n\nTHANK YOU FOR HAVE INSTALLED INTERCEPTOR\n\n"
    exit 1
}
	
if [ $(id -u) -ne 0 ];
	then
	clear
    Banner
	printf "${RED}\n\n[!]${WHITE}THIS INSTALLER MUST BE RUN AS ROOT TRY WITH SUDO :)\n\n"
	exit 1
fi
clear
Banner
installer
