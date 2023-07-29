#install Mysql
echo
printf -- "\e[0m\e[37m-> Installation de Mysql\e[0m";
printf -- "\n";
install_dependencies () {
	sudo apt-get -y install mariadb-server mariadb-client 1>>$logfile 2>>$errlog
	printf -- "\e[90mMysql a bien été installer\e[22m"
}
install_dependencies
sleep 1
echo
echo

#configure mysql
echo
printf -- "\e[0m\e[37m-> Configuration de MySQL\e[0m";
printf -- "\n";
configure_mysql () {
	# sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('${dbpass}') WHERE User = 'root'" 1>>$logfile 2>>$errlog &&
	# sudo mysql -e "FLUSH PRIVILEGES" 1>>$logfile 2>>$errlog
	# sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${dbpass}'" 1>>$logfile 2>>$errlog &&
	# mysql -uroot -p$dbpass -e "FLUSH PRIVILEGES" 1>>$logfile 2>>$errlog
	printf -- "\e[90mMot de passe MySQL mis à jour pour l'utilisateur: root\e[22m"
	printf -- "\n";
	printf -- "\e[90mPrivilèges flushed\e[22m"
}
configure_mysql
sleep 1
echo
echo
