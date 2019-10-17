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
 
touch /opt/testfile22.tes

destroy_unit 
