# Installation de WordPress en automatique

&nbsp;

### Conditions préalables

- Serveur VPS avec accès root exécutant Ubuntu 20.04, 21.04, 22.04 LTS **(Ne fonctionne pas avec 23.04 LTS)**
- Domaine enregistré avec un enregistrement IPv4 pointant vers le serveur VPS

&nbsp;

### Description

- Script shell qui permet une configuration facile d'un serveur Linux avec Php8.2, MySQL, Nginx, WordPress, Domain et SSL. Tout ce dont vous avez besoin pour démarrer rapidement votre développement et ignorer le travail manuel de configuration du serveur.

&nbsp;

### Résultats

- Le serveur VPS s'exécutera sur la dernière installation WordPress
- Le serveur VPS installera php8.2, MySQL et NGINX
- Le serveur VPS créera et remplira une nouvelle base de données MySQL
- Le serveur VPS créera et configurera tous les services sans interaction
- Le serveur VPS configurera le domaine et installera un certificat SSL
- Les fichiers de site WordPress seront disponibles dans `/root/var/www/html/puffme`

&nbsp;

## Comment utiliser

&nbsp;

### Installer Git

`sudo apt install git -y`

### cloner le repository

`git clone https://github.com/Shad0w59i/WordPress-Auto.git WordPress-Auto`

### Exécuter

`cd WordPress-Auto && sudo chmod +x *` 

`sudo ./run.sh`

&nbsp;
&nbsp;

Copyright (c) 2023, Shad0w59i

&nbsp;

Published under GNU GENERAL PUBLIC LICENSE.
More info: https://www.gnu.org/licenses/
