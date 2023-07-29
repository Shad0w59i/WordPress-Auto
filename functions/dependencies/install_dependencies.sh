#install first dependencies
printf -- "\e[0m\e[37m-> Installation des dépendances\e[0m";
printf -- "\n";
install_first_dependencies () {
	sudo apt-get -y install software-properties-common ca-certificates lsb-release apt-transport-https 1>>$logfile 2>>$errlog
	printf -- "\e[90mLes dépendances suivantes ont été installées: software-properties-common ca-certificates lsb-release apt-transport-https\e[22m"
}
install_first_dependencies
sleep 1

#update
printf -- "\e[0m\e[37m-> Mises à jour du système\e[0m";
printf -- "\n";
get_update () {
	sudo apt-get update 1>>$logfile 2>>$errlog
	printf -- "\e[90mMise à jour terminée\e[22m"
}
get_update
sleep 1

#install first dependencies
printf -- "\e[0m\e[37m-> Installation des dépendances\e[0m";
printf -- "\n";
install_first_dependencies () {
	sudo apt-get -y install git nano ntp unzip software-properties-common ca-certificates lsb-release apt-transport-https 1>>$logfile 2>>$errlog
	printf -- "\e[90mLes dépendances ont bien été installer\e[22m"
}
install_first_dependencies
sleep 1
