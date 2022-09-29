#!/bin/bash

echo "CiAgXyAgICBfICAgICAgICAgICBfICAgICAgIF8gICAgICAgICAgX19fX18gICAgICAgICAgIF8gICAgICAgXyAgIAogfCB8ICB8IHwgICAgICAgICB8IHwgICAgIHwgfCAgICAgICAgLyBfX19ffCAgICAgICAgIChfKSAgICAgfCB8ICAKIHwgfCAgfCB8XyBfXyAgIF9ffCB8IF9fIF98IHxfIF9fXyAgfCAoX19fICAgX19fIF8gX18gXyBfIF9fIHwgfF8gCiB8IHwgIHwgfCAnXyBcIC8gX2AgfC8gX2AgfCBfXy8gXyBcICBcX19fIFwgLyBfX3wgJ19ffCB8ICdfIFx8IF9ffAogfCB8X198IHwgfF8pIHwgKF98IHwgKF98IHwgfHwgIF9fLyAgX19fXykgfCAoX198IHwgIHwgfCB8XykgfCB8XyAKICBcX19fXy98IC5fXy8gXF9fLF98XF9fLF98XF9fXF9fX3wgfF9fX19fLyBcX19ffF98ICB8X3wgLl9fLyBcX198CiAgICAgICAgfCB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IHwgICAgICAgIAogICAgICAgIHxffCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfF98ICAgICAgICAK" | base64 -d

shopt -s nocasematch

#Checking if script is running at root.
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

#cating source list to ensure kali sources are within the correct repo
cat /etc/apt/sources.list

#Checking if you want to update repos
echo "Do you want to update repos continue?(Y/N)"
read input
if [[ "{$input}" == *"y"* ]]
then
apt update 
fi
if [[ "{$input}" == *"n"* ]]
then exit 1
echo "continue"
fi
#Checking if you want to upgrade packages
echo "Do you want to upgrade packages continue?(Y/N)"
read input
if [[ "{$input}" == *"y"* ]]
then
apt -y upgrade
fi
if [[ "{$input}" == *"n"* ]]
then exit 1
echo "continue"
fi
#Checking if you want to upgrade the distribution?
echo "Do you want to upgrade packages continue?(Y/N)"
read input
if [[ "{$input}" == *"y"* ]]
then
apt -y dist-upgrade
fi
if [[ "{$input}" == *"n"* ]]
then exit 1
echo "continue"
fi
#checking if you want to remove packages
echo "Do you want to auto remove packages?(Y/N)"
read input
if [[ "{$input}" == *"y"* ]]
then
apt-get -y autoremove
fi
if [[ "{$input}" == *"n"* ]]
then exit 1
echo "continue"
fi
done
