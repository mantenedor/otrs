# otrs
Instalação mínima do OTRS em container.

## Containers
São configurados 2 containers:

1. https://hub.docker.com/_/httpd
2. https://hub.docker.com/_/mariadb
### Softwares essenciais
Essencialmente, são configurados os softwares abaixo:
1. https://www.znuny.org/en
2. https://certbot.eff.org/instructions?ws=apache&os=debianbuster

## Scripts de instalação
Utilise scripts para ajustar a instalação.
O script "build.sh" executará, em sequência, todos os scripts presentes no diretório "scripts".

## Deoploy
execute:
```
./server.sh --build
```
Acesse: http://<FQDN>/otrs/installer.pl e siga o processo.

Considere a instalação do docker conforme: https://docs.docker.com/engine/install/debian/
