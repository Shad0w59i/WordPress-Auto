echo ""
#get wordpress
printf -- "\e[0m\e[37m-> Téléchargement de wordpress\e[0m";
printf -- "\n";
get_wordpress () {
  cd /tmp && wget https://wordpress.org/latest.tar.gz 1>>$logfile 2>>$errlog
  printf -- "\e[90mTéléchargement de la dernière version de wordpress\e[22m"
}
get_wordpress
echo ""
echo ""

#decompress files
printf -- "\e[0m\e[37m-> Décompression des fichiers\e[0m";
printf -- "\n";
decompress_files () {
  tar -zxvf latest.tar.gz 1>>$logfile 2>>$errlog
  printf -- "\e[90mFichiers décompressés\e[22m"
}
decompress_files
echo ""
echo ""

#install wordpress
printf -- "\e[0m\e[37m-> Installation de wordpress\e[0m";
printf -- "\n";
move_wordpress_directory () {
  sudo mv wordpress /var/www/html/puffme 1>>$logfile 2>>$errlog
  printf -- "\e[90mWordpress installé\e[22m"
}
move_wordpress_directory
echo ""
echo ""

#set privilegies
printf -- "\e[0m\e[37m-> Définition des privilèges\e[0m";
printf -- "\n";
set_privilegies () {
  sudo chown -R www-data:www-data /var/www/html/puffme/ 1>>$logfile 2>>$errlog &&
  sudo chmod -R 755 /var/www/html/puffme/ 1>>$logfile 2>>$errlog
  printf -- "\e[90mPrivilèges effectués\e[22m"
}
set_privilegies
echo ""
echo ""

#configuring wordpress
printf -- "\e[0m\e[37m-> Configuration de wordpress\e[0m";
printf -- "\n";
configure_wordpress () {
  sudo mv /var/www/html/puffme/wp-config-sample.php /var/www/html/puffme/wp-config.php 1>>$logfile 2>>$errlog &&
  sudo sed -i "s/^define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', 'puffme' );/" /var/www/html/puffme/wp-config.php 1>>$logfile 2>>$errlog &&
  sudo sed -i "s/^define( 'DB_USER', 'username_here' );/define( 'DB_USER', 'wppuffme' );/" /var/www/html/puffme/wp-config.php 1>>$logfile 2>>$errlog &&
  sudo sed -i "s/^define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${dbpass}' );/" /var/www/html/puffme/wp-config.php 1>>$logfile 2>>$errlog &&
  SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
  STRING='Mettez votre phrase unique ici' 1>>$logfile 2>>$errlog
  printf '%s\n' "g/$STRING/d" a "$SALT" . w | ed -s /var/www/html/puffme/wp-config.php 1>>$logfile 2>>$errlog
  printf -- "\e[90mWordpress configuré\e[22m"
}
configure_wordpress
echo ""
echo ""

#install nginx site config
printf -- "\e[0m\e[37m-> Configuration du serveur\e[0m";
printf -- "\n";
configure_nginx_site () {
  cd /etc/nginx/sites-available/ 1>>$logfile 2>>$errlog &&
  sudo curl -L -O https://raw.githubusercontent.com/ingeniatoreu/worplet/master/wordpress 1>>$logfile 2>>$errlog &&
  sudo ln -s /etc/nginx/sites-available/puffme /etc/nginx/sites-enabled/ 1>>$logfile 2>>$errlog
  printf -- "\e[90mServeur configuré\e[22m"
}
configure_nginx_site
echo ""
echo ""

#enable gzip
printf -- "\e[0m\e[37m-> Activation de gzip\e[0m";
printf -- "\n";
enable_gzip () {
  sudo sed -i "s|# gzip on;|gzip on;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_vary on;|gzip_vary on;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_disable "msie6";|gzip_disable "msie6";|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_proxied any;|gzip_proxied any;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_comp_level 6;|gzip_comp_level 6;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_buffers 16 8k;|gzip_buffers 16 8k;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_http_version 1.1;|gzip_http_version 1.1;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog &&
  sudo sed -i "s|# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;|gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;|g" "/etc/nginx/nginx.conf" 1>>$logfile 2>>$errlog
  printf -- "\e[90mgzip activé sur le serveur\e[22m"
}
enable_gzip
echo ""
echo ""

#configure domain
printf -- "\e[0m\e[37m-> Configuration du domaine\e[0m";
printf -- "\n";
configure_domain () {
  sudo sed -i "s|YOURDOMAINNAME|$server$serverip|g" "/etc/nginx/sites-available/puffme" 1>>$logfile 2>>$errlog &&
  printf -- "\e[90mDomaine configuré\e[22m"
}
configure_domain
echo ""
echo ""

#install SSL certificate
printf -- "\e[0m\e[37m-> Installation du SSL\e[0m";
printf -- "\n";
isntall_ssl () {
  sudo certbot --nginx --agree-tos --register-unsafely-without-email -d ${server}${serverip} --redirect --post-hook "service nginx start" 1>>$logfile 2>>$errlog
  printf -- "\e[90mSSL installé\e[22m"
}
isntall_ssl
echo ""
echo ""

#post install clean up
printf -- "\e[0m\e[37m-> Nettoyage\e[0m";
printf -- "\n";
clean_up () {
  sudo apt-get autoremove -y 1>>$logfile 2>>$errlog && sudo apt-get clean -y 1>>$logfile 2>>$errlog && sudo apt-get purge -y 1>>$logfile 2>>$errlog
  printf -- "\e[90mNettoyage terminé\e[22m"
}
clean_up 
echo ""
echo ""

#restart all services
printf -- "\e[0m\e[37m-> Redémarrage des services\e[0m";
printf -- "\n";
restart_services () {
  sudo systemctl restart nginx.service php7.2-fpm.service mysql.service 1>>$logfile 2>>$errlog
  printf -- "\e[90mServices redémarrés\e[22m\e[0m"
}
restart_services
echo ""
echo ""

#help text
printf -- "Votre WordPress est disponible @ \e[33m$h\e[0m";
printf -- "\n";
printf -- "Le journal d'installation complet est disponible sur @ \e[33m/var/log/worplet.log\e[0m";
printf -- "\n";
printf -- "Le journal des erreurs est disponible sur @ \e[33m/var/log/worplet_error.log\e[0m";
printf -- "\n";
printf -- "Merci d'avoir utilisé le script d'installation !";
printf -- "\n";
echo ""
