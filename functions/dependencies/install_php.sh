#get repository
echo
printf -- "\e[0m\e[37m-> Téléchargement du repository PHP\e[0m";
printf -- "\n";
get_ppa () {
	yes | sudo add-apt-repository ppa:ondrej/php 1>>$logfile 2>>$errlog
	printf -- "\e[90mRepository: ppa:ondrej/php\e[22m"
}
get_ppa
sleep 1
echo
echo

#install PHP
echo
printf -- "\e[0m\e[37m-> Installation de PHP8.2\e[0m";
printf -- "\n";
install_dependencies () {
	sudo apt-get -y install php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap 1>>$logfile 2>>$errlog
	printf -- "\e[90mPHP8.2 a bien été installer\e[22m"
}
install_dependencies
sleep 1
echo
echo

#configure php
echo
printf -- "\e[0m\e[37m-> Configuration de PHP\e[0m";
printf -- "\n";
configure_php () {
	sudo sed -i "s/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.2/fpm/php.ini 1>>$logfile 2>>$errlog &&
	sudo sed -i "s/^max_execution_time = 30/max_execution_time = 600/" /etc/php/8.2/fpm/php.ini 1>>$logfile 2>>$errlog &&
	sudo sed -i "s/^memory_limit = 128M/memory_limit = 256M/" /etc/php/8.2/fpm/php.ini 1>>$logfile 2>>$errlog &&
	sudo sed -i "s/^upload_max_filesize = 2M/upload_max_filesize = 64M/" /etc/php/8.2/fpm/php.ini 1>>$logfile 2>>$errlog &&
	sudo sed -i "s/^post_max_size = 8M/post_max_size = 64M/" /etc/php/8.2/fpm/php.ini 1>>$logfile 2>>$errlog
	printf -- "\e[90mcgi.fix_pathinfo fixé à 0 \e[22m"
	printf -- "\n";
	printf -- "\e[90mmax_execution_time fixé à 600 \e[22m"
	printf -- "\n";
	printf -- "\e[90mlimite_mémoire fixée à 256M \e[22m"
	printf -- "\n";
	printf -- "\e[90mupload_max_filesize fixé à 64M \e[22m"
	printf -- "\n";
	printf -- "\e[90mpost_max_size fixé à 64M \e[22m"
}
configure_php
sleep 1
echo
echo
