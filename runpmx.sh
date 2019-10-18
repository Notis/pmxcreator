#!/bin/bash

PATH="/usr/local/bin:/usr/bin:/bin"
SHELL="/bin/bash"
LANG="ru_RU.UTF-8"

#------------change run script for startup systemd unit
change_unit () {
	cp /opt/install/unit2 /etc/systemd/system/pmxrunonce.service
	/usr/bin/systemctl daemon-reload
	}

#-----------delete systemd unit
destroy_unit () {
	/usr/bin/systemctl disable pmxrunonce.service
	rm /etc/systemd/system/pmxrunonce.service
	/usr/bin/systemctl daemon-reload
	}
#------------

#install utilites
/usr/bin/apt-get install -y curl jq open-iscsi || echo $? > /opt/err.log

#install postfix
debconf-set-selections <<< "postfix postfix/mailname string $(hostname).$(dnsdomainname)"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Local only'"
debconf-set-selections <<< "postfix postfix/mynetworks string 127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128"
debconf-set-selections <<< "postfix postfix/protocols string ipv4"
/usr/bin/apt-get install -y postfix


cp /etc/hosts /opt/hosts.bck
#create new hosts file for install proxmox 1st string localhost
echo "127.0.0.1	localhost localhost.localdomain" > /opt/hosts
#EXT_IP=$(tail -n 15 /var/lib/dhcp/dhclient.leases  | grep fixed-address | sed 's/;//; s/.*ss //')
#EXT_IP=192.168.0.169
#2nd string put ip , fqdn, hostname and "pvelocalhost"
echo "$(hostname -i)  $(cat /proc/sys/kernel/hostname).$(dnsdomainname) $(cat /proc/sys/kernel/hostname) pvelocalhost" >> /opt/hosts

touch /opt/testfile.tes

destroy_unit
