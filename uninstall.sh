#!/bin/bash
#
# Worplet uninstall script

#store max open files number as variable
get_open_files () {
    getmaxfiles="sudo cat /proc/sys/fs/file-max"
    eval "$getmaxfiles"
    maxfiles=$(eval "$getmaxfiles")
}

#remove swap file
sudo swapoff /swapfile
sudo rm /swapfile
sudo sed -i "s|/swapfile none swap sw 0 0||g" "/etc/fstab"

#remove custom entries from config files
sudo sed -i "s|fs.file-max: $maxfiles|fs.file-max: 768|g" "/etc/sysctl.conf"
sudo sed -i "s|vm.vfs_cache_pressure=50||g" "/etc/sysctl.conf"
sudo sed -i "s|vm.swappiness=10||g" "/etc/sysctl.conf"

#reset and update firewall
yes | sudo ufw reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow 22
yes | sudo ufw enable

#remove dependencies
sudo apt-get -y remove nginx php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap mariadb-server mariadb-client
sudo apt-get -y autoremove nginx php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap mariadb-server mariadb-client
sudo apt-get -y purge nginx php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap mariadb-server mariadb-client
sudo rm -rf /etc/nginx
sudo rm -rf /var/www

#clean up
sudo dpkg --configure -a
sudo apt-get update
sudo apt-get -f install -y
sudo apt-get autoremove -y
sudo apt-get clean

#remove files and folders
sudo rm /var/log/worplet.log
sudo rm /var/log/worplet_err.log