#!/bin/bash

###
### Download latest version Wasabi
### Install wasabi in Tails Persistent storage
### Restore previos wallet folder
###

# Import Public Key 
curl https://raw.githubusercontent.com/zkSNACKs/WalletWasabi/master/PGP.txt | gpg --import

# Download latest release
curl -s https://api.github.com/repos/zkSNACKs/WalletWasabi/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -

# Verify download
deb_package_asc="$(find . -name "Wasabi*.deb.asc")"
gpg --verify $deb_package_asc


# Install
deb_package="$(find . -name "Wasabi*.deb")"
sudo dpkg -i $deb_package
    
    



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

