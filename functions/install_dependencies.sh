#install first dependencies
printf -- "\e[0m\e[37m-> Installation des dépendances\e[0m";
printf -- "\n";
install_first_dependencies () {
	sudo apt-get -y install software-properties-common ca-certificates lsb-release apt-transport-https 1>>$logfile 2>>$errlog
	printf -- "\e[90mLes dépendances suivantes ont été installées: software-properties-common ca-certificates lsb-release apt-transport-https\e[22m"
}
install_first_dependencies
echo ""
echo ""

#get repository
printf -- "\e[0m\e[37m-> Téléchargement des repository\e[0m";
printf -- "\n";
get_ppa () {
	yes | sudo add-apt-repository ppa:ondrej/php 1>>$logfile 2>>$errlog
	yes | sudo add-apt-repository ppa:ondrej/nginx-mainline 1>>$logfile 2>>$errlog
	# yes | sudo add-apt-repository ppa:certbot/certbot 1>>$logfile 2>>$errlog
	printf -- "\e[90mRepository: ppa:ondrej/php\e[22m"
	printf -- "\n";
	printf -- "\e[90mRepository: ppa:ondrej/nginx-mainline\e[22m"
	# printf -- "\n";
	# printf -- "\e[90mRepository: ppa:certbot/certbot\e[22m"
}
get_ppa
echo ""
echo ""

#update
printf -- "\e[0m\e[37m-> Mises à jour en cours d'exécution\e[0m";
printf -- "\n";
get_update () {
	sudo apt-get update 1>>$logfile 2>>$errlog
	printf -- "\e[90mMise à jour terminée\e[22m"
}
get_update
echo ""
echo ""

#install dependencies
printf -- "\e[0m\e[37m-> Installation des dépendances\e[0m";
printf -- "\n";
install_dependencies () {
	sudo apt-get -y install git nano ntp ntpdate nginx php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap mariadb-server mariadb-client 1>>$logfile 2>>$errlog
	printf -- "\e[90mLes dépendances suivantes ont été installées: git nano ntp ntpdate nginx php8.2-fpm php8.2-common php8.2-mbstring php8.2-xmlrpc php8.2-gd php8.2-xml php8.2-mysql php8.2-cli php8.2-zip php8.2-curl php8.2-soap php8.2-intl php8.2-ldap mariadb-server mariadb-client\e[22m"
}
install_dependencies
echo ""

#install Certbot
printf -- "\e[0m\e[37m-> Installation de Certbot\e[0m";
printf -- "\n";
install_certbot () {
	sudo snap install core; sudo snap refresh core 1>>$logfile 2>>$errlog
	sudo apt remove certbot
	sudo snap install --classic certbot 1>>$logfile 2>>$errlog
	sudo ln -s /snap/bin/certbot /usr/bin/certbot
	printf -- "\e[90mCertbot installait avec succès\e[22m"
}
install_certbot
echo ""