#!/bin/bash

sudo dpkg -i Wasabi-1.1.11.1.deb

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

