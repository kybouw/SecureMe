#! /bin/bash

echo 'Hello, daemons! Welcome to the cpix script!'
echo 'The script is now running...'

function main {
	echo 'main function running...'
#	begin scripts
	udpf #apt-get update
##	toolbelt #install tools
	ugpf #apt-get upgrade
	noport #enables ufw
	lockdown #locks accounts
	nopass #sets password policies
	sshfix #sshconfig
##	scruboff #get rid of software
#	end of scripts
	updatedb
	hahahome='HOME'
	chmod 0750 ${!hahahome}
	echo 'Script is complete...'
	echo "Begin fishing for points...\n"
	read -n1 -r -p "Press space to continue..." key
	exit 0
	
}
function udpf {
	echo ""
	echo "Check your sources! Software & Updates\n"
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		echo "Updating sources..."
		apt-get update
	else
		echo "Exiting script..."
		exit 1
	fi
	echo "Finished updating"
}
function toolbelt {
	echo ""
	echo 'installing utilities...'
	apt-get -y install vim ufw gufw firefox clamav netstat nmap libpam-cracklib lsof chkrootkit
	echo 'Finished installs'
}
function ugpf {
	echo ""
	echo 'Upgrading packages...'
	apt-get upgrade
	echo 'Finished upgrading'
}
function noport {
	echo ""
	echo "Enabling Uncomplicated Firewall..."
	ufw enable
	echo "change net.ipv4.tcp_syncookies entry from 0 to 1\n"
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/sysctl.conf
	else
		echo 'Exiting script...'
		exit 1
	fi
	echo "Verify rules..."
	ufw status
	read -n1 -r -p "Press space to continue..." key
	echo "Finished managing rules"
}
function lockdown {
	echo ""
	echo "Locking root user"
	passwd -l root
	echo "root locked"
	echo "Lock any unauthorized accounts NOW! Remove admin rights from non-admins"
	read -n1 -r -p "Press space to continue..." key
}
function nopass {
	echo ''
	echo "Changing password policies requires manual interaction\n"
	echo "Please open Mr. Silva's checklist for instructions\n"
	echo 'First we will edit login.defs'
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/login.defs
	else
		echo 'Exiting script...'
		exit 1
	fi
	echo "Now we will edit common-password\n"
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/pam.d/common-password
	else
		echo 'Exiting script...'
		exit 1
	fi
	echo 'Password policies configured'
}
function sshfix {
	echo ''
	echo 'Turn off root login settings for ssh'
	echo 'This must be performed manually'
	echo 'Change the line PermitRootLogin to no'
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/ssh/sshd_config
	else
		echo 'Exiting script...'
		exit 1
	fi
	read -n1 -r -p "Press 1 to turn on ssh, space to turn off..." key
	if [ "$key" = '1' ]; then
		service ssh restart
	else
		service ssh stop
	fi
	echo 'Finished ssh config editing'
}
function scruboff {
	echo ''
	echo 'Getting rid of software you dont need'
	apt-get remove vsftp nc ncat
	echo 'check for unwanted apps manually'
	chkrootkit
	freshclam
	clamscan -i -r --remove=yes /
	service --status-all | less
	sudo dpkg --get --selections | less
	netstat -tulpn | grep -i LISTEN | less
	cat /etc/rc.local | less
	crontab -e | less
	echo 'Please remove any unwanted apps NOW'
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		apt-get --purge autoremove
	else
		echo 'Exiting script...'
		exit 1
	fi
	echo 'Finished uninstalling'
}
if [ "$(id -u)" != "0" ]; then
	echo 'Please run as root'
	exit
else
	main
fi
