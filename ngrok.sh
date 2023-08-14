#!/bin/bash

NGROK=$(dirname $(realpath $0))/bin/ngrok

if [[ $# != 1 && $# != 2 ]]; then
    echo "Input ngrok command"
    echo "  ex) $0 ssh"
    exit 1
fi

if [ $# == 2 ]; then
    options="--authtoken $2"
fi

case "$1" in
    "ssh")
        ${NGROK} tcp 22 ${options}
        ;;
    "lab")
        ${NGROK} http 18888 --host-header="localhost:8888" ${options} # docker port forwarding 18888->8888
        ;;
    *)
        echo "'$1' is invalid command"
        exit 1
        ;;
esac

