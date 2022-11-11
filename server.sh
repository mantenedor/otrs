#!/bin/bash

#
# Script de operções básicas de container.
# Autor: Wagton Azevedo
# Criado: 10/2022
#


CONTAINER_NAME=`pwd | cut -d'/' -f2`
CD=10 # Tempo para reflexão

function BUILD {
        echo "Destruindo containers..."
        docker compose down
        echo "Destruindo volumes..."
	docker volume ls -q | grep "$CONTAINER_NAME" | xargs docker volume rm
        echo "Construindo containers..."
        docker compose up -d
        echo ""
	docker ps
        echo ""
        echo 'Acrescente "&& docker logs '$CONTAINER_NAME' -f" para ver os logs em tempo de execução.'
        echo ""
}
function START {
        echo "Iniciando containers..."
        docker compose up -d
        echo ""
	docker ps
        echo ""
        echo 'Acrescente "&& docker logs '$CONTAINER_NAME' -f" para ver os logs em tempo de execução.'
        echo ""
}
function RESTART {
        echo "Reiniciando containers..."
        docker compose down && docker compose up -d
        echo ""
	docker ps
        echo ""
        echo 'Acrescente "&& docker logs '$CONTAINER_NAME' -f" para ver os logs em tempo de execução.'
        echo ""
}
function STOP {
        echo "Parando contaires..."
        docker-compose down
        echo ""
	docker ps
}
function DESTROY {
        echo ""
        echo "#########################################################"
        echo "###################### ATENÇÃO ##########################"
        echo "#########################################################"
        echo ""
        echo "Este parâmetro irá destruir todos os containers e imagens neste host."
        echo "Você tem $CD segundos para cancelar esta operação..."
        echo ""
        for((i = $CD; i >= 1; i--))do
                echo "Destruição total em $i..."
                sleep 1
        done
        echo ""
        echo "Destruindo contaires..."
        docker compose down
        docker ps -q | xargs docker stop
        docker ps -aq | xargs docker rm
        echo ""
        echo "Destruindo imagens..."
        docker images -q | xargs docker image rm
        echo ""
        echo "Destruindo volumes..."
        docker volume ls -q | xargs docker volume rm
        echo ""
        echo "Tentativa destruição concluída."
        echo ""

}
function HELP {\
        echo ""
        echo "Utilize: ./sso.sh [OPTIONS]."
        echo ""
        echo "--build) Destroi containers e volumes recriando o conteiner conforme o docker-compose.yml."
        echo "--start) Recria os containers conforme o docker-compose.yml."
        echo "--stop) Destroi containers conforme o docker-compose.yml."
        echo "--restart) Destroi containers e recria conforme o docker-compose.yml."
        echo "--destroy) Destroi containers e imagens presentes no host."
        echo "--help) Exibe esta ajuda."
        echo ""
}

case $1 in
        --build) BUILD;;
        --start) START;;
        --stop) STOP;;
        --restart) RESTART;;
        --destroy) DESTROY;;
        --help) HELP;;
        *) HELP;;
esac
