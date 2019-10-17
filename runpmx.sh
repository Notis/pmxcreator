#!/bin/bash

PATH="/usr/local/bin:/usr/bin:/bin"
SHELL="/bin/bash"
LANG="ru_RU.UTF-8"


change_unit () {
	cp /opt/install/unit2 /etc/systemd/system/pmxrunonce.service
	/usr/bin/systemctl daemon-reload
	}

#-----------
destroy_unit () {
	/usr/bin/systemctl disable pmxrunonce.service
	rm /etc/systemd/system/pmxrunonce.service
	/usr/bin/systemctl daemon-reload
	}
#------------
 
/usr/bin/apt-get install -y curl || echo $? > /opt/err.log

cp /etc/hosts /opt/hosts.bck
echo "127.0.0.1	localhost localhost.localdomain" > /opt/hosts
#EXT_IP=$(tail -n 15 /var/lib/dhcp/dhclient.leases  | grep fixed-address | sed 's/;//; s/.*ss //')
#EXT_IP=192.168.0.169
EXT_IP=$(hostname --ip_address)
echo "$EXT_IP	$(cat /proc/sys/kernel/hostname).$(dnsdomainname) $(cat /proc/sys/kernel/hostname) pvelocalhost" >> /opt/hosts

touch /opt/testfile.tes

destroy_unit 
