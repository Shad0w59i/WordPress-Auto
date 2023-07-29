#get user input for domain
echo -e ""
echo -e "\e[0m\e[37mLaissez le domaine vide et appuyez sur Entrée pour utiliser l'IP externe du serveur au lieu du domaine pour cette installation !\e[0m"
echo -e ""
read -p "Entrez le nom de domaine (fqdn sans http://www.):" domainname
server=$domainname
printf -- "\n";

#check if string is empty
check_domain () {
    if [[ -z "$server" ]]; then
        echo -e "\e[91m"
        printf -- "\n";
        printf -- "Champ de domaine vide. Utilisation de l'adresse IP externe du serveur pour l'installation.";
        serverip=$(dig +short myip.opendns.com @resolver1.opendns.com)
        printf -- "\n";
        echo -e "\e[0m"
        ${0}
    else
        #use input in a loop
        for h in $server
        do
            host $h 2>&1
            if [ $? -eq 0 ]
            then
                printf -- "\n";
            else
                echo -e "\e[91m"
                printf -- "\n";
                printf -- "$h n'est pas un fqdn";
                printf -- "\n";
                printf -- "Veuillez réessayer.";
                printf -- "\n";
                echo -e "\e[0m"
                ${0}
            fi
        done
    fi
}
check_domain
sleep 1
echo
echo

#read server info
cpu=$(grep -c ^processor /proc/cpuinfo) 1>>$logfile 2>>$errlog
memorytotal=$(grep MemTotal /proc/meminfo | awk '{print $2 / 1024}') 1>>$logfile 2>>$errlog
storagetotal=$(df -h --output=size --total | awk 'END {print $1}') 1>>$logfile 2>>$errlog

#write server info
echo
server_info () {
    printf -- "Informations sur le serveur";
    printf -- "\n";
    printf -- "\e[90mvCPU: $cpu\e[22m";
    printf -- "\n";
    printf -- "\e[90mRAM: $memorytotal Mb\e[22m";
    printf -- "\n";
    printf -- "\e[90mSTOCKAGE: $storagetotal\e[22m";
    printf -- "\n";
    printf -- "\n";
}
server_info
sleep 1
echo
echo

#add swap file equal to total system memory size
echo
printf -- "\e[0m\e[37m-> Ajout du swap\e[0m";
printf -- "\n";
add_swap_file () {
    ram=$(free -h | awk '/^Mem:/ { print $2 }') 1>>$logfile 2>>$errlog
    sudo fallocate -l ${ram} /swapfile 1>>$logfile 2>>$errlog
    ls -lh /swapfile 1>>$logfile 2>>$errlog
    sudo chmod 600 /swapfile 1>>$logfile 2>>$errlog && sudo mkswap /swapfile 1>>$logfile 2>>$errlog && sudo swapon /swapfile 1>>$logfile 2>>$errlog && sudo swapon 1>>$logfile 2>>$errlog
    sudo echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab 1>>$logfile 2>>$errlog
    swapsize=$(free -h | awk '/^Swap:/ { print $2 }') 1>>$logfile 2>>$errlog
    printf -- "\e[90mTaille du swap définie sur $swapsize\e[22m";
}
add_swap_file
sleep 1
echo
echo

#increase maximum number of open files limit
echo
printf -- "\e[0m\e[37m-> Augmentation du nombre maximum de fichiers ouverts\e[0m";
printf -- "\n";
increase_open_files () {
    getmaxfiles="sudo cat /proc/sys/fs/file-max" 1>>$logfile 2>>$errlog
    eval "$getmaxfiles" 1>>$logfile 2>>$errlog
    maxfiles=$(eval "$getmaxfiles") 1>>$logfile 2>>$errlog
    echo "fs.file-max: $maxfiles" | sudo tee -a /etc/sysctl.conf 1>>$logfile 2>>$errlog
    printf -- "\e[90mLimite maximale de fichiers ouverts fixée à $maxfiles\e[22m";
}
increase_open_files
sleep 1
echo
echo

#improve swappiness & cache pressure
echo
printf -- "\e[0m\e[37m-> Amélioration de la perméabilité et de la pression du cache\e[0m";
printf -- "\n";
improve_swappiness_cache_pressure () {
    sudo echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf 1>>$logfile 2>>$errlog
    sudo echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf 1>>$logfile 2>>$errlog
    printf -- "\e[90mSwappiness est fixé à 10\e[22m";
    printf -- "\n";
    printf -- "\e[90mPression de cache réglée à 50\e[22m";
}
improve_swappiness_cache_pressure
sleep 1
echo
echo

#generate a new sha256 password for mysql database
echo
generate_password () {
    dbpassword=$(date +%s | sha256sum | base64 | head -c 32 ;)
    dbpass=$dbpassword
}
generate_password
sleep 1
echo
echo