#!/bin/bash

###
### Download latest version Wasabi
### Install wasabi in Tails Persistent storage
### Restore previos wallet folder
###
#WORK_FOLDER=/home/amnesia/Persistent/
WORK_FOLDER=/home/llorens/tails-wks/

#latest version
WASABI_LATEST_VERSION="$(curl -s https://api.github.com/repos/zkSNACKs/WalletWasabi/releases/latest | grep "tag_name." | cut -d '"' -f 4 | cut -c 2- 2>/dev/null)"
WASABI_DEBIAN_PACKAGE_URL=https://github.com/zkSNACKs/WalletWasabi/releases/download/v${WASABI_LATEST_VERSION}/Wasabi-${WASABI_LATEST_VERSION}.deb
WASABI_DEBIAN_PACKAGE_ASC_URL=https://github.com/zkSNACKs/WalletWasabi/releases/download/v${WASABI_LATEST_VERSION}/Wasabi-${WASABI_LATEST_VERSION}.deb.asc

WASABI_LATEST_VERSION_FILE=${WORK_FOLDER}wasabi/.wasabi.txt
CURRENT=""
if [ -f $WASABI_LATEST_VERSION_FILE ]; then
    CURRENT=$(cat $WASABI_LATEST_VERSION_FILE)
fi
if [ "$CURRENT" != "$WASABI_DEBIAN_PACKAGE_URL" ]; then
   # Download
   # Import Public Key 
   curl https://raw.githubusercontent.com/zkSNACKs/WalletWasabi/master/PGP.txt | gpg --import
    
   wget -q $WASABI_DEBIAN_PACKAGE_URL
   wget -q $WASABI_DEBIAN_PACKAGE_ASC_URL
   
   # Verify download
   #deb_package_asc="$(find . -name "Wasabi*.deb.asc")"
   deb_package_asc=Wasabi-${WASABI_LATEST_VERSION}.deb.asc
   gpg --verify $deb_package_asc

   if [ $? == 0 ]; then
        # Install
	#deb_package="$(find . -name "Wasabi*.deb")"
	deb_package=Wasabi-${WASABI_LATEST_VERSION}.deb
	sudo dpkg -i $deb_package
        # Mark current version
   	echo $WASABI_DEBIAN_PACKAGE_URL > $WASABI_LATEST_VERSION_FILE
    else
        echo "ERROR UPGRADING WASABI - GPG FAILED"
    fi
   
   
fi

wassabee </dev/null &>/dev/null &

sleep 5s

pkill wassabee

echo "*********************"

ls -1 -d */

echo "*********************"

while true
do	
    read -p "Enter wallet to open: " wallet_name
    FOLDER="$wallet_name"

    if [ -d "$FOLDER" ]
    then
        echo "$FOLDER wallet found."
	cd "$FOLDER"/.walletwasabi/
	cp -r client/* ~/.walletwasabi/client
	echo "Your files has been moved to wasabi folder"
	break
    else
	echo ""$FOLDER" wallet dont exist"
	continue
fi
done

wassabee </dev/null &>/dev/null &

