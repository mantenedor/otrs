#!/bin/bash

#
# Script de pos instalação.
# Autor: Wagton Azevedo
# Criado: 10/2022
#

cd $WORKDIR

function DAEMON {
	echo "Inciando o daemon..."
	#docker exec -it otrs su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs
	docker exec -it otrs su -c "/opt/otrs/bin/Cron.sh start" -s /bin/bash otrs
}

function HELP {\
        echo ""
        echo "Utilize: ./4-pos_install.sh [OPTIONS]."
        echo ""
        echo "--start) Inicia os procedimentos pos instalação."
        echo "--help) Exibe esta ajuda."
        echo ""
}

case $1 in
        --start) DAEMON;;
        --help) HELP;;
        *) HELP;;
esac
