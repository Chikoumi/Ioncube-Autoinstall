English Version 
==================

## Ioncube-Autoinstall ##

This is a simply bash script to install Ioncube on your Debian or Ubuntu server.

#### Donwload & install ####

Just download it and execute :
`chmod +x eng_ioncube.sh && ./eng_ioncube.sh`

#### Test installation ####

You can run this code on a php page :
```
<?php
	if(extension_loaded('ionCube Loader')){
		echo "Installed";
	} else {
		echo "Not installed ...";
	}
?>
```

Version Française
====================

## Installation automatique de Ioncube ##

Il s'agit d'un script Bahs permettant d'installer Ioncube sans soucis.

#### Téléchargement et installation ####

Il faut le téléchager puis l'exécuter : 
`chmod +x fr_ioncube.sh && ./fr_ioncube.sh`

#### Test de l'installation ####
Vous pouvez utiliser ce code dans une page php : 

```
<?php
	if(extension_loaded('IonCube Loader')){
		echo "Installé";
	} else {
		echo "Non installé";
	}
```
