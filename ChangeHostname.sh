#!/bin/bash

#ask for new hostname
echo Please enter the new hostname:

read varhost

echo The hostname you entered is "\""$varhost"\""
echo Is this correct? "("y/n")"

read varyn

if [ "$varyn" = "y" ];then
	echo Changing hostname

	#rename /etc/hostname and /etc/hosts, adding .old to both
	mv /etc/hostname /etc/hostname.old
	mv /etc/hosts /etc/hosts.old

	#echo the entered hostname into /etc/hostname and rewrite the /etc/hosts file with the new hostname 
	echo $varhost >> /etc/hostname
	echo "127.0.0.1 	 localhost
127.0.1.1 	$varhost

::1	localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
" >> /etc/hosts
echo Hostname has been changed. Would you like to reboot now? "("y/n")"
read varyn1
if [ "$varyn1" = "y" ];then
	echo REBOOTING NOW!
	sudo reboot
else
	echo Reboot later to finish hostname change.
	exit
fi
else
	echo CANCELLED!
	exit
fi
