#add more rules to firewall
echo
printf -- "\e[0m\e[37m-> Mise à jour du firewall\e[0m";
printf -- "\n";
update_firewall () {
	sudo ufw allow 'Nginx HTTP' 1>>$logfile 2>>$errlog &&
	sudo ufw allow 'Nginx HTTPS' 1>>$logfile 2>>$errlog &&
	sudo ufw allow 'Nginx Full' 1>>$logfile 2>>$errlog
	printf -- "\e[90mFirewall mis à jour\e[22m"
}
update_firewall
sleep 1
echo
echo
