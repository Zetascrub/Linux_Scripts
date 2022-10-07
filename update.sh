#!/bin/bash

#Checking if script is running at root.
if [ "$EUID" -ne 0 ]
  then echo "[!] Please run as root"
  exit
fi

banner(){
echo "CiAgIF9fICBfXyAgICAgICAgICBfXyAgICAgIF9fICAgICAgICAgIF9fX19fICAgICAgICAgICBfICAgICAgIF9fIAogIC8gLyAvIC9fX18gIF9fX18vIC9fX18gXy8gL19fX18gICAgIC8gX19fL19fX19fX19fX18oXylfX18gIC8gL18KIC8gLyAvIC8gX18gXC8gX18gIC8gX18gYC8gX18vIF8gXCAgICBcX18gXC8gX19fLyBfX18vIC8gX18gXC8gX18vCi8gL18vIC8gL18vIC8gL18vIC8gL18vIC8gL18vICBfXy8gICBfX18vIC8gL19fLyAvICAvIC8gL18vIC8gL18gIApcX19fXy8gLl9fXy9cX18sXy9cX18sXy9cX18vXF9fXy8gICAvX19fXy9cX19fL18vICAvXy8gLl9fXy9cX18vICAKICAgIC9fLyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC9fLyAgICAgICAgICAgCg==" | base64 -d
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
  ;;
esac


echo "[!] Update Finished!"

