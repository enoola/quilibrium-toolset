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


files=$(curl -s https://releases.quilibrium.com/release | grep $release_os-$release_arch)
qnode_latestrelease=$(curl -s https://releases.quilibrium.com/release | grep $release_os-$release_arch | grep -E "node-.*-(darwin|linux)-(amd64|arm64)"|grep -v dgst)
echo -e "derniere version:" $qnode_latestrelease
echo '----'
echo -e $files" \r\n"
exit

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

