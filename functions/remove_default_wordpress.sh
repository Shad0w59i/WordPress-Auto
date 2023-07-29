#delete default themes wordpress
printf -- "\e[0m\e[37m-> Suppression des thèmes par défaut wordpress\e[0m";
printf -- "\n";
remove_themes () {
  cd /var/www/html/puffme/wp-content/themes/ 1>>$logfile 2>>$errlog &&
  sudo rm -r twentytwentytwo 1>>$logfile 2>>$errlog &&
  sudo rm -r twentytwentyone 1>>$logfile 2>>$errlog
  printf -- "\e[90mSuppression du thèmes twentytwentytwo\e[22m"
  printf -- "\n";
  printf -- "\e[90mSuppression du thèmes twentytwentyone\e[22m"
}
remove_themes
sleep 1

#delete default plugins wordpress
printf -- "\e[0m\e[37m-> Suppression des thèmes par défaut wordpress\e[0m";
printf -- "\n";
remove_plugins () {
  cd /var/www/html/puffme/wp-content/plugins/ 1>>$logfile 2>>$errlog &&
  sudo rm -r akismet 1>>$logfile 2>>$errlog &&
  sudo rm -r hello.php 1>>$logfile 2>>$errlog
  printf -- "\e[90mSuppression du plugins akismet\e[22m"
  printf -- "\n";
  printf -- "\e[90mSuppression du plugins hello.php\e[22m"
}
remove_plugins
sleep 1
