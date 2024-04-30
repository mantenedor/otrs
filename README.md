# OTRS
Instalação mínima do OTRS em container.

Considere uma instalação conforme abaixo:
 1. docker conforme: https://docs.docker.com/engine/install/debian/;
 2. Nome do coantainer "otrs";
 3. Diretório de instalação "/opt".

## Containers
São configurados 2 containers:

1. https://hub.docker.com/_/httpd
2. https://hub.docker.com/_/mariadb
### Softwares essenciais
Essencialmente, são configurados os softwares abaixo:
1. https://www.znuny.org/en
2. https://certbot.eff.org/instructions?ws=apache&os=debianbuster

## Deploy

No diretórrio de sua preferência digite:
```
git clone https://github.com/mantenedor/otrs.git
```
execute:
```
docker compose up -d
```
Verifique se a palavra "Funfa!" aparece na url do seu servidor:
```
http://<seu_IP_ou_URL>
```
Verifique a tela de instalação do OTRS está disponível em:
```
http://<seu_IP_ou_URL>/otrs/installer.pl
```
Execute o cron
```
docker exec -it otrs su -c "/opt/otrs/bin/Cron.sh start" -s /bin/bash otrs
```

Reveja suas configurações de rede/firewall e repita o processo, em caso de insucesso.
Utilize o comando abaixo entre os testes:
```
docker compose down && docker system prune --all --volumes --force
```

Em "http://<seu_IP_ou_URL>/installer.pl", selecione "Usar um banco existente", informe o banco, usuário, senha e endereço do bando de dados presente no arquivo "docker-compose.yml".
No endereço do banco você pode infiormar "db", caso não tenha alterado o compose.
Siga o processo de isntalação até o final.

Você pode configurar o TLS utilizando o script "3-certbot.sh".
Você precisa executar essa operação dento do container.

Intalando o certbot:
```
docker exec -it otrs /bin/bash /opt/scripts/3-certbot.sh -i
```
Gerando o certificado:
```
docker exec -it otrs /bin/bash /opt/scripts/3-certbot.sh -n /usr/local/apache2/htdocs/ exemplo.com.br mail@exemplo.com.br
```
Habilitando renovação:
```
docker exec -it otrs /bin/bash /opt/scripts/3-certbot.sh -r
```
Antes de habilitar o SSL verifique se as configurações do seu virtualhost estão de acordo com suas preferências em "./web/conf/httpd-ssl.conf" e "./web/conf/httpd-conf".

Altere o caminho do certificado para seu domínio:
```
<VirtualHost *:443>
...
        SSLCertificateFile "/etc/letsencrypt/live/<dominio_do_certificado>/fullchain.pem"
        SSLCertificateKeyFile "/etc/letsencrypt/live/<e_p_substiyuir_abestado>/privkey.pem"
...
</VirtualHost>
```
Fora do container, para habilitar SSL, execute:
```
./3-certbot.sh --ssl
```
Reinicie o contaner para aplicar a mudança:
```
# docker restart otrs
```

