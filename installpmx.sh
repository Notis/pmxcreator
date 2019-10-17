#!/bin/bash

VESION_CODENAME=$(lsb_release -sc)
VE_REL="6"


mkdir /opt/install
cp ./runpmx.sh /opt/install
cp ./createvm.sh /opt/install/
chmod +x /opt/install/runpmx.sh
chmod +x /opt/install/createvm.sh
cp ./pmxrunonce.service /etc/systemd/system/
cp ./unit2 /opt/install/unit2
systemctl daemon-reload
systemctl enable pmxrunonce.service 

if [ ! -f "/etc/apt/sources.list.d/pve-install-repo.list" ] 
then
echo "deb http://download.proxmox.com/debian/pve $VERSION_CODENAME pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
fi
wget http://download.proxmox.com/debian/proxmox-ve-release-${VE_REL}.x.gpg -O - | apt-key add -

echo "reboot"

# apt update && apt full-upgrade -y && echo "reboot"
