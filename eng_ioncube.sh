#!/bin/bash
# IonCube Auto Install
# chk.harmony-hosting.com

# Script begin
clear
cd /root

# Define apt-get variable
APT_GET="apt-get -y -qq"

# Information
echo -e "\\033[1;34m#### \\033[1;33m        IonCube Auto install        \\033[1;34m #### \\033[0;39m"
echo -e "\\033[1;34m#### \\033[1;33m  By Chk : chk.harmony-hosting.com  \\033[1;34m #### \\033[0;39m"
echo "Run script ..."

#  Update
echo -n "[In progress] Update package ..."
$APT_GET update
echo -e "\r\e[0;32m[OK]\e[0m Update package                   "


#  32 or 64 bits
echo -n "[In progress] Detect Linux architecture ..."
DIST="$(command dpkg --print-architecture)" 
if [ "${DIST}" = "i386" ]; then 
    DIST="x86" 
elif [ "${DIST}" = "amd64" ]; then 
    DIST="x86-64" 
fi
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Detect Linux architecture : $DIST              "

# download tar.gz archive
echo -n "[In progress] Donwload the tar.gz archive ..."
wget -q "http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_lin_${DIST}.tar.gz"
echo -e "\r\e[0;32m[OK]\e[0m Donwload the tar.gz archive                                  "

# Move in directory
echo -n "[In progress] Move to /usr/local ..."
mv ioncube_loaders_lin_${DIST}.tar.gz /usr/local/ioncube_loaders_lin_${DIST}.tar.gz
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Move to /usr/local                           "

# Go to directory
echo -n "[In progress] Go into /usr/local ..."
cd /usr/local 
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Go into /usr                           "

# Extract
echo -n "[In progress] Extract tar.gz in   /usr/local ..."
tar -xzf ioncube_loaders_lin_${DIST}.tar.gz > /dev/null
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Extract tar.gz in  /usr/local                           "
echo -n "[In progress] remove the tar.gz file ..."
rm ioncube_loaders_lin_${DIST}.tar.gz
cd
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m remove the tar.gz file                        "

# Php version
echo -n "[In progress] Detect PHP version ..."
VER_PHP="$(command php --version 2>'/dev/null' \
    | command head -n 1 \
    | command cut --characters=5-7)"
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Detect PHP version  : $VER_PHP   "

#  Add IonCube to PHP
echo -n "[In progress] Add IonCube to PHP ..."
echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_${VER_PHP}.so" > /etc/php5/conf.d/ioncube.ini
sed -i '1izend_extension=/usr/local/ioncube/ioncube_loader_lin_${VER_PHP}.so' /etc/php5/apache2/php.ini
sleep 3s
echo -e "\r\e[0;32m[OK]\e[0m Add IonCube to PHP                "

#  Reboot apache2 & Php
echo -n "[In progress] Reboot apache2 & Php ..."
test -e '/etc/init.d/php5'
command service 'php5' 'restart'

test -e '/etc/init.d/apache2'
command service 'apache2' 'force-reload'
echo -e "\r\e[0;32m[OK]\e[0m Reboot apache2 & Php          "
echo -e "\\033[1;32m ####  Installation réussie  #### \\033[0;39m"
