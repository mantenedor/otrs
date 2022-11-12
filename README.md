# otrs
https://www.znuny.org/en

# Containers
São criados 2 containers:

1. Debian (apache pearl, etc)
2. Mysql

# Script de instalação
O script "otrs_install.sh" baixa e instala todos os pacotes.

# Deoploy
execute:
```
./server.sh --build
```
Inicie o apache: 
```
docker exec -it otrs /etc/init.d/apache2 start
```
Acesse: http://<FQDN>/otrs/installer.pl e siga o processo.

Considere a instalação do docker conforme: https://docs.docker.com/engine/install/debian/ 
