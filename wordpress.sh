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

# Fonction pour poser une question avec une réponse par défaut
# poser_question() {
#     read -p "$1 [$2]: " reponse
#     reponse=${reponse:-$2}
#     echo "$reponse"
# }

# Fonction pour poser une question avec une liste d'options
poser_question() {
    local question="$1"
    shift
    local options=("$@")
    local choix=$(whiptail --title "Question" --checklist "$question" 20 60 10 "${options[@]}" 3>&1 1>&2 2>&3)
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
# package1=$(poser_question "Voulez-vous installer Nginx ?" "non")
# package2=$(poser_question "Voulez-vous installer PHP8.2 ?" "non")
# package3=$(poser_question "Voulez-vous installer Mysql ?" "non")
# package4=$(poser_question "Voulez-vous installer Certbot (domaine uniquement) ?" "non")
# package5=$(poser_question "Voulez-vous installer Wordpress ?" "non")
# if [[ $package1 == "oui" ]]; then
#     package6=$(poser_question "Voulez-vous supprimer les thèmes, plugins par défaut de Wordpress ?" "non")
# fi

package1=$(poser_question "Voulez-vous installer Nginx ?" "off" "Nginx" "non")
package2=$(poser_question "Voulez-vous installer PHP8.2 ?" "off" "PHP8.2" "non")
package3=$(poser_question "Voulez-vous installer Mysql ?" "off" "Mysql" "non")
package4=$(poser_question "Voulez-vous installer Certbot (domaine uniquement) ?" "off" "Certbot" "non")
package5=$(poser_question "Voulez-vous installer Wordpress ?" "off" "Wordpress" "non")
if [[ $package5 == "Wordpress" ]]; then
    package6=$(poser_question "Voulez-vous supprimer les thèmes, plugins par défaut de Wordpress ?" "off" "Oui" "non")
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
if [[ $package1 == "Nginx" ]]; then
    source functions/dependencies/install_nginx.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install PHP
if [[ $package2 == "PHP8.2" ]]; then
    source functions/dependencies/install_php.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install Mysql
if [[ $package3 == "Mysql" ]]; then
    source functions/dependencies/install_mysql.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#certbot
if [[ $package4 == "Certbot" ]]; then
    source functions/dependencies/install_certbot.sh
    sleep 1
    packages_installes=$((packages_installes + 1))
    pourcentage=$((packages_installes * 100 / total_packages))
    echo
    afficher_chargement $pourcentage
fi

#install Wordpress
if [[ $package5 == "Wordpress" ]]; then
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
    if [[ $package6 == "Oui" ]]; then
        source functions/remove_default_wordpress.sh
        sleep 1
        packages_installes=$((packages_installes + 1))
        pourcentage=$((packages_installes * 100 / total_packages))
        echo
        afficher_chargement $pourcentage
    fi
fi

echo "*********************************************************************************"

if [[ $package5 == "oui" ]]; then
    echo "Votre WordPress est disponible https://$h"
    echo "*********************************************************************************"
fi

echo "Le journal d'installation complet est disponible dans /var/log/wordpress_auto.log"
echo "Le journal des erreurs est disponible dans /var/log/wordpress_auto_error.log"
echo "*********************************************************************************"