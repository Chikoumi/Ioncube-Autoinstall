Ioncube-Autoinstall
===================

This is a simply bash script to install Ioncube on your Debian or Ubuntu server.

#### Donwload & install ####

Just download it and execute :
`chmod +x ioncube.sh && ./ioncube.sh`

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
