#!/bin/bash

set -e

if [[ $2 == "" ]]; then
    echo missing arguments!
    echo usage: ./touchTorrent.sh torrentfile.torrent autodl_class
    exit 1
fi

download_location="$(egrep "\"path\".+$2\"" /home/dockerman/dockers/deluge/config/autoadd.conf -B12 | grep "download_location" | cut -d'"' -f4)"

input_file="$(winpath "$1")"

torrent_internal_dir="$(ctorrent -x "$input_file" | grep Directory: | cut -d' ' -f 2-)"

if [[ "$torrent_internal_dir" == "" ]]; then
    # se falhou em pegar a pasta, tenta pegar o nome do primeiro arquivo
    # vamos rezar aos deuses dos torrents pra ninguem ter feito um torrent desgraçado com varios arquivos sem pasta
    torrent_internal_dir="$(ctorrent -x "$input_file" | grep -Po '^(?:<1> +)\K.+(?= \[.+\]$)')"

    if [[ "$torrent_internal_dir" == "" ]]; then
        echo "failed to get torrent's internal dir"
        exit 1
    fi
    fullpath="${download_location/\/media\/HI2TB/\/mnt\/bugueira\/media}/$torrent_internal_dir"
    
    echo touching "$fullpath"
    mkdir -p "$(dirname "$fullpath")"
    touch "$fullpath"
    chmod 777 "$fullpath"
else
    fullpath="${download_location/\/media\/HI2TB/\/mnt\/bugueira\/media}/$torrent_internal_dir"
    
    echo creating "$fullpath"
    mkdir -p "$fullpath"
    chmod 777 "$fullpath"
fi

sleep 1