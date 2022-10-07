#!/bin/bash

#Checking if script is running at root.
if [ "$EUID" -ne 0 ]
  then echo "[!] Please run as root"
  exit
fi

banner(){
echo "CiAgICBfX19fICAgICAgICBfIF9fICAgIF9fICAgX19fX18gICAgICAgICAgIF8gICAgICAgX18gICAgIAogICAvIF9fIClfXyAgX18oXykgL19fXy8gLyAgLyBfX18vX19fX19fX19fXyhfKV9fXyAgLyAvXyAgICAKICAvIF9fICAvIC8gLyAvIC8gLyBfXyAgLyAgIFxfXyBcLyBfX18vIF9fXy8gLyBfXyBcLyBfXy8gICAgCiAvIC9fLyAvIC9fLyAvIC8gLyAvXy8gLyAgIF9fXy8gLyAvX18vIC8gIC8gLyAvXy8gLyAvXyAgICAgIAovX19fX18vXF9fLF8vXy9fL1xfXyxfLyAgIC9fX19fL1xfX18vXy8gIC9fLyAuX19fL1xfXy8gICAgICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgL18vICAgICAgICAgICAgICAgCg==" | base64 -d
}

update-repo(){
	echo "[+] Updating Repos"
	apt update > /dev/null 2>&1
}

update-package(){
	echo "[+] Updating Packages"
	apt -y upgrade > /dev/null 2>&1
}

update-distro(){
	echo "[+] Updating Distribution"
	apt -y dist-upgrade > /dev/null 2>&1
}

remove-packages(){
	echo "[+] Removing Old Packages"
	apt-get -y autoremove > /dev/null 2>&1
}

install-applications(){
	echo "[+] Installing applications"
	# Apt Gets
	echo "[+] Installing: Python3, Python2, seclist, terminator"
	apt-get -y install python3-pip python2 seclists terminator smbclient python3-ldap3 python3-yaml python3-impacket > /dev/null 2>&1
	# Git Clones
	mkdir /opt/tools
	cd /opt/tools
	echo "[+] Installing: enum4linux-ng"
	git clone https://github.com/cddmp/enum4linux-ng.git  > /dev/null 2>&1
	echo "[+] Installing: Test-SSL"
	git clone --depth 1 https://github.com/drwetter/testssl.sh.git  > /dev/null 2>&1
	echo "[+] Installing: Impacket"
	git clone https://github.com/CoreSecurity/impacket.git  > /dev/null 2>&1
	python3 opt/tools/impacket/setup.py install  > /dev/null 2>&1
	echo "[+] Installing: Powersploit" 
	git clone https://github.com/PowerShellMafia/PowerSploit.git  > /dev/null 2>&1
	echo "[+] Installing: Winpeas and Linpeas"
	git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git  > /dev/null 2>&1
	echo "[+] Installing: Linenum"
	git clone https://github.com/rebootuser/LinEnum.git	 > /dev/null 2>&1
	echo "[+] Installing: Responder"
	git clone https://github.com/lgandx/Responder.git  > /dev/null 2>&1
	echo "[+] Installing: DNScan"
	git clone https://github.com/rbsec/dnscan.git  > /dev/null 2>&1
	pip3 install -r opt/tools/dnscan/requirements.txt  > /dev/null 2>&1
	echo "[+] Installing: Wifite"
	git clone https://github.com/kimocoder/wifite2.git  > /dev/null 2>&1
	pip3 install -r opt/tools/wifite2/requirements.txt  > /dev/null 2>&1
	# Gem
	echo "[+] Installing: Evil-Winrm"
	gem install evil-winrm  > /dev/null 2>&1
}

repo-sources(){
#cating source list to ensure kali sources are within the correct repo
echo "[!] Repo Sources"
cat /etc/apt/sources.list
}

# Display Banner
banner

# Set case-insensitivity
shopt -s nocasematch

#Display Repo Sources
#repo-sources

# Checking For Unattended Mode
case "$1" in
-u)
	echo "[!] Unattended Mode"
	update-repo
	update-package
	update-distro
	remove-packages
	install-applications
	;;
*)
	echo "[!] Attended Mode - use the '-u' argument for unattended mode"
	#Checking if you want to update repos
	echo "[?] Do you want to update repos continue?(Y/N)"
	read input
	if [[ "{$input}" == *"n"* ]]; then 
		continue
	elif [[ "{$input}" == *"y"* ]]; then
		update-repo
	fi


	#Checking if you want to upgrade packages
	echo "[?] Do you want to update repos continue?(Y/N)"
	read input
	if [[ "{$input}" == *"n"* ]]; then 
		continue
	elif [[ "{$input}" == *"y"* ]]; then
		update-package
	fi


	#Checking if you want to upgrade distro
	echo "[?] Do you want to update repos continue?(Y/N)"
	read input
	if [[ "{$input}" == *"n"* ]]; then 
		continue
	elif [[ "{$input}" == *"y"* ]]; then
		update-distro
	fi


	#checking if you want to remove packages
	echo "[?] Do you want to remove old packages?(Y/N)"
	read input
	if [[ "{$input}" == *"n"* ]]; then 
		continue
	elif [[ "{$input}" == *"y"* ]]; then
		remove-packages
	fi

	#Building
	#checking if you want to install applications
	echo "[?] Do you want to install applications?(Y/N)"
	read input
	if [[ "{$input}" == *"n"* ]]; then 
		continue
	elif [[ "{$input}" == *"y"* ]]; then
		install-applications
	fi
  ;;
esac


echo "[!] Build Finished!"

