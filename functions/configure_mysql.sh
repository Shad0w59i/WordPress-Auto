echo ""
#configure mysql
printf -- "\e[0m\e[37m-> Configuration de MySQL\e[0m";
printf -- "\n";
configure_mysql () {
	# sudo mysql -e "UPDATE mysql.user SET Password = PASSWORD('${dbpass}') WHERE User = 'root'" 1>>$logfile 2>>$errlog &&
	# sudo mysql -e "FLUSH PRIVILEGES" 1>>$logfile 2>>$errlog
	sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${dbpass}'" 1>>$logfile 2>>$errlog &&
	sudo mysql -uroot -p$dbpass -e "FLUSH PRIVILEGES" 1>>$logfile 2>>$errlog
	printf -- "\e[90mMot de passe MySQL mis à jour pour l'utilisateur: root\e[22m"
	printf -- "\n";
	printf -- "\e[90mPrivilèges flushed\e[22m"
}
configure_mysql
echo ""