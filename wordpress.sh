#!/bin/bash
#

# Fonction pour afficher le message d'accueil
afficher_message_accueil() {
    echo "*********************************************************************************"
    echo "*              Bienvenue dans le script démarrage Serveur (Linux)               *"
    echo "*********************************************************************************"
    echo "*                                                                               *"
    echo "*   ░██████╗██╗░░██╗░█████╗░██████╗░░█████╗░░██╗░░░░░░░██╗███████╗░█████╗░██╗   *"
    echo "*   ██╔════╝██║░░██║██╔══██╗██╔══██╗██╔══██╗░██║░░██╗░░██║██╔════╝██╔══██╗██║   *"
    echo "*   ╚█████╗░███████║███████║██║░░██║██║░░██║░╚██╗████╗██╔╝██████╗░╚██████║██║   *"
    echo "*   ░╚═══██╗██╔══██║██╔══██║██║░░██║██║░░██║░░████╔═████║░╚════██╗░╚═══██║██║   *"
    echo "*   ██████╔╝██║░░██║██║░░██║██████╔╝╚█████╔╝░░╚██╔╝░╚██╔╝░██████╔╝░█████╔╝██║   *"
    echo "*   ╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░░╚═════╝░░╚════╝░╚═╝   *"
    echo "*                                                                               *"
    echo "*********************************************************************************"
}

# Fonction pour installer whiptail
sudo apt-get install -y whiptail

# Fonction pour poser une question avec une liste d'options
poser_question() {
    local question="$1"
    shift
    local options=()
    for option in "$@"; do
        options+=("$option" "" off)
    done
    local choix=$(whiptail --title "Question" --separate-output --checklist "$question" 20 60 10 "${options[@]}" 3>&1 1>&2 2>&3)
    echo "$choix"
}

# Fonction pour afficher le chargement en pourcentage
afficher_chargement() {
    local pourcentage=$1
    local longueur_barre=50
    local remplissage=$((pourcentage * longueur_barre / 100))
    printf "["
    for ((i = 0; i < longueur_barre; i++)); do
        if ((i < remplissage)); then
            printf "\e[32m#\e[0m"  # Affichage en vert
        else
            printf "-"
        fi
    done
    printf "] %d%%\r" $pourcentage
}

# Message d'accueil
afficher_message_accueil

# Poser les questions à l'utilisateur
choices=$(poser_question "Sélectionnez les packages à installer :" \
          "Nginx" \
          "PHP8.2" \
          "Mysql" \
          "Certbot" \
          "Wordpress")

# Vérifier si Wordpress a été sélectionné
if echo "$choices" | grep -q "Wordpress"; then
    # Poser la question sur la suppression des thèmes et plugins par défaut
    if whiptail --title "Question" --yesno "Supprimer les thèmes et plugins par défaut de Wordpress ?" 10 60; then
        choices="$choices Wordpress_Extra"
    else
        choices="$choices Wordpress"
    fi
fi

# Installation des packages sélectionnés
echo "Installation en cours..."

total_packages=14
packages_installes=0

#output handling
source functions/output_handling.sh
sleep 1
packages_installes=$((packages_installes + 1))
pourcentage=$((packages_installes * 100 / total_packages))
echo
afficher_chargement $pourcentage

#install dependencies
source functions/dependencies/install_dependencies.sh
sleep 1
packages_installes=$((packages_installes + 1))
pourcentage=$((packages_installes * 100 / total_packages))
echo
afficher_chargement $pourcentage

#install Nginx
if echo "$choices" | grep -q "Nginx"; then
    source functions/dependencies/install_nginx.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install PHP
if echo "$choices" | grep -q "PHP8.2"; then
    source functions/dependencies/install_php.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install Mysql
if echo "$choices" | grep -q "Mysql"; then
    source functions/dependencies/install_mysql.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#certbot
if echo "$choices" | grep -q "Certbot"; then
    source functions/dependencies/install_certbot.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install Wordpress
if echo "$choices" | grep -q "Wordpress"; then
    source functions/config.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/enable_services.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/update.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/set_firewall.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/update_firewall.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/create_database.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    source functions/install_wordpress.sh  
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage

    #remove default Plugins, Themes wordpress
    if echo "$choices" | grep -q "Wordpress_Extra"; then
        source functions/remove_default_wordpress.sh
        sleep 1
        packages_installes=$((packages_installes + 1))
        pourcentage=$((packages_installes * 100 / total_packages))
        echo
        afficher_chargement $pourcentage
    fi
fi

echo "*********************************************************************************"
echo "Informations sur le serveur";
echo "vCPU: $cpu";
echo "\e[RAM: $memorytotal Mb";
echo "\e[STOCKAGE: $storagetotal";
echo "*********************************************************************************"

if echo "$choices" | grep -q "Wordpress"; then
    echo "Votre WordPress est disponible https://$h"
    echo "*********************************************************************************"
fi

if echo "$choices" | grep -q "Mysql"; then
    echo "Création de la base de données : puffme"
    echo "Création de l'utilisateur : wppuffme | Mot de passe : $dbpass"
    echo "*********************************************************************************"
fi

if echo "$choices" | grep -q "PHP8.2"; then
    echo "version de PHP installée : PHP8.2"
    echo "Configuration :"
    echo "cgi.fix_pathinfo fixé à 0"
	echo "max_execution_time fixé à 360"
	echo "limite_mémoire fixée à 256M"
	echo "upload_max_filesize fixé à 64M"
	echo "post_max_size fixé à 64M"
    echo "*********************************************************************************"
fi

echo "Le journal d'installation complet est disponible dans /var/log/wordpress_auto.log"
echo "Le journal des erreurs est disponible dans /var/log/wordpress_auto_error.log"
echo "*********************************************************************************"