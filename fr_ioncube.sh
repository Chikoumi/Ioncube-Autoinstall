#!/bin/bash
# Script d'autoinstallation de Ioncube
# Depot orginal sur chk.harmony-hosting.com


# On mets en place le script
clear
cd /root

#on definie la variable d'apt-get
APT_GET="apt-get -y -qq"

# annonce du script
echo -e "\\033[1;34m#### \\033[1;33mInstallation automatique de Ioncube \\033[1;34m #### \\033[0;39m"
echo -e "\\033[1;34m#### \\033[1;33m  By Chk : chk.harmony-hosting.com  \\033[1;34m #### \\033[0;39m"
echo "Lancement du script ..."

#  Mise a jour des paquets
echo -n "[En cours] Mise à jour des paquets ..."
$APT_GET update
echo -e "\r\e[0;32m[OK]\e[0m Mise a jour des paquets                   "

# Installation de CURL
echo -n "[En cours] Installation de PHP-CURL ..."
$APT_GET install php5-curl
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Installation de PHP-CURL                  " 

# On detecte si debian est en 32 ou 64 bits
echo -n "[En cours] Détection de l'architecture ..."
DIST="$(command dpkg --print-architecture)" 
if [ "${DIST}" = "i386" ]; then 
    DIST="x86" 
elif [ "${DIST}" = "amd64" ]; then 
    DIST="x86-64" 
fi
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Détection de l'architecture : $DIST              "

# On telecharge l'archive depuis les depots avec la variable obtenue
echo -n "[En cours] Téléchargement de l'archive ..."
wget -q "http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_${DIST}.tar.gz"
echo -e "\r\e[0;32m[OK]\e[0m Téléchargement de l'archive                                  "

# On transfere l'archive vers le bon endroit
echo -n "[En cours] Trasnfert de l'arichve vers /usr/local ..."
mv ioncube_loaders_lin_${DIST}.tar.gz /usr/local/ioncube_loaders_lin_${DIST}.tar.gz
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Transfert de l'archive dans /usr/local                           "

# On accede au dossier
echo -n "[En cours] Accés au dossier /usr/local ..."
cd /usr/local 
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Accés au dossier /usr                           "

# On extrait l'archive
echo -n "[En cours] Extraction de l'archive dans  /usr/local ..."
tar -xzf ioncube_loaders_lin_${DIST}.tar.gz > /dev/null
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Extraction de l'archive dans /usr/local                           "
echo -n "[En cours] Suppresion de l'archive ..."
rm ioncube_loaders_lin_${DIST}.tar.gz
cd
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Supression de l'archive                          "

# On detecte la version de PHP
echo -n "[En cours] Détection de la version de PHP ..."
VER_PHP="$(command php --version 2>'/dev/null' \
    | command head -n 1 \
    | command cut --characters=5-7)"
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Détection de la version de PHP : $VER_PHP   "

#  On ajoute l'exetension au fichier de configuration de php
echo -n "[En cours] Ajout de l'extension à PHP ..."
echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_${VER_PHP}.so" > /etc/php5/conf.d/ioncube.ini
sed -i "1izend_extension=/usr/local/ioncube/ioncube_loader_lin_${VER_PHP}.so" /etc/php5/apache2/php.ini
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Ajout de l'extension à PHP                "

#  pour finir on redemmare php et apache
echo -n "[En cours] Redémarrage d'apache2 ..."
test -e '/etc/init.d/php5'
command service 'php5' 'restart'

test -e '/etc/init.d/apache2'
command service 'apache2' 'force-reload'
echo -e "\r\e[0;32m[OK]\e[0m Redémarrage d'apache2          "
echo -e "\\033[1;32m ####  Installation réussie  #### \\033[0;39m"
