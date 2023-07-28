echo ""
#configure nginx
printf -- "\e[0m\e[37m-> Configuration de Nginx\e[0m";
printf -- "\n";
configure_nginx () {
	# sudo sed -i "s|worker_connections 768;|worker_connections ${maxfiles};|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog
	printf -- "\e[90mLes connexions de nginx sont réglées sur : ${maxfiles}\e[22m"
}
configure_nginx
echo ""