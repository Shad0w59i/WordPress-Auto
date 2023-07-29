#set standard firewall options
echo
printf -- "\e[0m\e[37m-> Paramétrage du firewall\e[0m";
printf -- "\n";
set_firewall () {
	sudo ufw default deny incoming 1>>$logfile 2>>$errlog && 
	sudo ufw default allow outgoing 1>>$logfile 2>>$errlog && 
	sudo ufw allow ssh 1>>$logfile 2>>$errlog && 
	yes | sudo ufw enable 1>>$logfile 2>>$errlog && 
	sudo ufw allow 80 1>>$logfile 2>>$errlog && 
	sudo ufw allow 443 1>>$logfile 2>>$errlog
	printf -- "\e[90mFirewall configuré\e[22m"
}
set_firewall
sleep 1
echo
echo
