#install Certbot
echo
printf -- "\e[0m\e[37m-> Installation de Certbot\e[0m";
printf -- "\n";
install_certbot () {
	sudo snap install core; sudo snap refresh core 1>>$logfile 2>>$errlog
	sudo apt remove certbot
	sudo snap install --classic certbot 1>>$logfile 2>>$errlog
	sudo ln -s /snap/bin/certbot /usr/bin/certbot
	echo
	printf -- "\e[90mCertbot installait avec succès\e[22m"
	echo
}
install_certbot
sleep 1
echo
echo
