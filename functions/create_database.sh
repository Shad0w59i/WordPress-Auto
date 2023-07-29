#create mysql database
printf -- "\e[0m\e[37m-> Création de base de données\e[0m";
printf -- "\n";
create_database () {
	sudo mysql -uroot -e "CREATE DATABASE puffme;" 1>>$logfile 2>>$errlog &&
	sudo mysql -uroot -e "CREATE USER 'wppuffme'@'localhost' IDENTIFIED BY '${dbpass}';" 1>>$logfile 2>>$errlog &&
	sudo mysql -uroot -e "GRANT ALL ON puffme.* TO 'wppuffme'@'localhost' IDENTIFIED BY '${dbpass}' WITH GRANT OPTION;" 1>>$logfile 2>>$errlog &&
	sudo mysql -uroot -e "FLUSH PRIVILEGES;" 1>>$logfile 2>>$errlog
	printf -- "\e[90mCréation de la base de données : puffme\e[22m"
	printf -- "\n";
	printf -- "\e[90mCréation de l'utilisateur : wppuffme | Mot de passe : $dbpass\e[22m"
	printf -- "\n";
	printf -- "\e[90mAccordé des privilèges à l'utilisateur : wppuffme\e[22m"
	printf -- "\n";
	printf -- "\e[90mPrivilèges flushed\e[22m"
}
create_database
sleep 1