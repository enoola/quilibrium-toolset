#!/bin/bash

#on determine type d'os et archi de la machine
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    release_os="linux"
    if [[ $(uname -m) == "aarch64"* ]]; then
        release_arch="arm64"
    else
        release_arch="amd64"
    fi
else
    release_os="darwin"
    release_arch="arm64"
fi

SCRIPT_WORKING_DIR=/root/ceremonyclient/node
cd $SCRIPT_WORKING_DIR

files=$(curl -s https://releases.quilibrium.com/release | grep $release_os-$release_arch)
qnode_latestrelease=$(curl -s https://releases.quilibrium.com/release | grep $release_os-$release_arch | grep -E "node-.*-(darwin|linux)-(amd64|arm64)"|grep -v dgst)
echo -e "derniere version:" $qnode_latestrelease
#echo '----'
#echo -e $files" \r\n"
#exit

new_release=false

for file in $files; do
   version=$(echo "$file" | cut -d '-' -f 2)
   #if ! test -f "./$file"; then
        curl "https://releases.quilibrium.com/$file" > "$file"
        new_release=true
    #else
	#echo "le fichier $file existe deja."
    #fi
done

#chmod +x https://releases.quilibrium.com/release
echo "Will make node binary $fnode executable"

QUILIBRIUM_NODE_BIN=$(ls -tr $SCRIPT_WORKING_DIR | grep -v dgst | grep 2.0. | tail -n 1)
chmod +x "$fnode"

exit
QUILIBRIUM_SERVICE_FILENAME=ceremonyclient.service
QUILIBRIUM_SERVICE_FILENAME=ceremonyclient-cluster.service
echo "will modify your service file"

SYS_SRVC_PATH=/lib/systemd/system/

#assuming it is ceremonyclient (made by by @Lamatt https://www.quilibrium.one)
if !test -f "$SYS_SRVC_PATH_DIR/$QUILIBRIUM_SERVICE_FILENAME" then
	"Wrong guess.. $SYS_SRVC_PATH_DIR/QUILIBRIUM_SERVICE_FILENAME ."
	exit
done

#need to let the option to user
#nprendre en compte le cas d'un 
