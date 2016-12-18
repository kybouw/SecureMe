#! /bin/bash

echo 'Hello, daemons! Welcome to the cpix script!'
echo 'The script is now running...'

function main {
	echo 'main function running...'

#	begin scripts
<<<<<<< HEAD
	udpf #apt-get update
	toolbelt #install tools
	ugpf #apt-get upgrade
=======

	aptf #apt-get update #
	toolbelt #install tools #
>>>>>>> 5492321287d2c316abbbaa9c812a868ceafed003
	noport #enables ufw
	lockdown #locks accounts #
	nopass #sets password policies
	sshfix #sshconfig #
	nomedia #gets rid of media files #
	scruboff #get rid of software

#	end of scripts


	echo 'Script is complete...'
	echo "Begin fishing for points...\n"
	cont
}


#function that pauses between steps
function cont {
	read -n1 -p "Press space to continue, q to quit" key
	if [ "$key" = "" ]; then
		echo "Continuing..."
	else
		echo "Quitting script..."
		exit 1
	fi
}

#apt update
function aptf {
	echo ""
	echo "Check your sources! Software & Updates\n"
	gnome-terminal -e "sudo nano /etc/apt/sources.list"
	cont
	apt-get -y update
	apt-get -y upgrade
	apt-get -y install --reinstall coreutils
	echo "Finished updating"
}

#install tools to use for misc purposes
function toolbelt {
	echo ""
<<<<<<< HEAD
	echo 'installing utilities...'
	apt-get -y install \
vim \
ufw \
gufw \
firefox \
clamav \
netstat \
nmap \
libpam-cracklib \
lsof \
chkrootkit
=======
	echo "installing utilities..."
	apt-get -y install \
	vim \
	ufw \
	gufw \
	firefox \
	clamav \
	netstat \
	nmap \
	libpam-cracklib \
	lsof \
	locate \
	chkrootkit
>>>>>>> 5492321287d2c316abbbaa9c812a868ceafed003
	echo 'Finished installs'
	updatedb
	echo "Updated database"
}



#blocks ports and traffic
function noport {
	echo ""
	echo "Enabling Uncomplicated Firewall..."
	ufw enable
	cont

	echo "preventing ddos attacks"
	sysctl -w net.ipv4.tcp_syncookies=1
	cont

	echo "Verify rules..."
	ufw status
	cont
	echo "Finished managing rules"
}


#locks root and home
function lockdown {
	echo ""
	echo "Locking root user"
	passwd -l root
	echo "root locked"
	hahahome='HOME'
	chmod 0750 ${!hahahome}
	echo "home directory locked"
	cont
}


#manages password policies
#this should be its own script
function nopass {
	echo ""
<<<<<<< HEAD
	echo "Changing password policies requires manual interaction\n"
	echo "Please open Mr. Silva's checklist for instructions\n"
=======
	echo "Changing password policies requires manual interaction"
	echo "Please open Mr. Silva's checklist for instructions"

	#login.defs
>>>>>>> 5492321287d2c316abbbaa9c812a868ceafed003
	echo 'First we will edit login.defs'
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/login.defs
	else
		echo 'Exiting script...'
		exit 1
	fi

	#common-password
	echo "Now we will edit common-password\n"
	read -n1 -r -p "Press space to continue..." key
	if [ "$key" = '' ]; then
		vim /etc/pam.d/common-password
	else
		echo 'Exiting script...'
		exit 1
	fi


	echo 'Password policies configured'
	cont
}




#easy point here
function sshfix {
	echo ''
	echo 'Turn off root login settings for ssh'
	echo 'This must be performed manually'

	#permitrootlogin
	echo 'Change the line PermitRootLogin to no'
	read -n1 -r -p "Press space to continue..." key
	gnome-terminal -e "sudo vim /etc/ssh/sshd_config"
	cont

	#enables/disables ssh
	read -n1 -r -p "Press 1 to turn on ssh, space to turn off..." key
	if [ "$key" = '1' ]; then
		service ssh restart
	else
		service ssh stop
	fi


	echo 'Finished ssh config editing'
	cont
}


#finds and deletes media files
function nomedia {
	echo "Deleting media..."
	find / -name '*.mp3' -type f -delete
	find / -name '*.mov' -type f -delete
	find / -name '*.mp4' -type f -delete
	find / -name '*.avi' -type f -delete
	find / -name '*.mpg' -type f -delete
	find / -name '*.mpeg' -type f -delete
	find / -name '*.flac' -type f -delete
	find / -name '*.m4a' -type f -delete
	find / -name '*.flv' -type f -delete
	find / -name '*.ogg' -type f -delete
	find /home -name '*.gif' -type f -delete
	find /home -name '*.png' -type f -delete
	find /home -name '*.jpg' -type f -delete
	find /home -name '*.jpeg' -type f -delete
	echo "Media deleted"
	cont
}



function scruboff {
	echo ''
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

#actually running the script
unalias -a #Get rid of aliases
echo "unalias -a" >> ~/.bashrc
echo "unalias -a" >> /root/.bashrc
if [ "$(id -u)" != "0" ]; then
	echo 'Please run as root'
	exit
else
	main
fi
