#!/bin/bash

function INSTALLCERTBOT {
	echo ""
	echo "Instalando pacotes..." 
	apt install python3-certbot -y
	echo ""
}

function NEWCERTIFY {
	echo ""
	echo "Emitindo certificado para:" 
	echo "Domínio: $DOMAIN E-mail: $MAIL"
	echo ""
	echo "Salvando arquivo de verificação em: $DOCUMENT_ROOT"
	certbot certonly --webroot -w $DOCUMENT_ROOT -d $DOMAIN --email "$MAIL" 
}

function RENEWCERTIFY {
	echo ""
	echo "Configurando renovação de certificado..." 
	certbot renew --dry-run
	echo ""
}

function SSLON {
	echo ""
	echo "Habilitando SSL..." 
	sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' ../web/conf/httpd.conf
	echo ""
	echo "Caso queira revereter, comente as linhas abaixo em ../web/conf/httpd.conf:"
	echo ""
	echo "LoadModule ssl_module modules/mod_ssl.so"
	echo "LoadModule socache_shmcb_module modules/mod_socache_shmcb.so"
	echo "Include conf/extra/httpd-ssl.conf"
	echo ""
	echo "utilize docker restart <container> para aplicar a mudança."
	echo ""
}	

DOCUMENT_ROOT="$2"
DOMAIN="$3"
MAIL="$4"

function HELP {
	clear
	echo ""
 	echo "utilize ./3-certbot.sh [OPTIONS]"	
	echo ""
	echo "Para um novo certificado utilize ./3certbot [DocumentRoot] [Domínio] [E-mail]"
	echo ""
	echo "Exemplo:"
	echo "./3-certbot.sh -n /usr/local/apache2/htdocs/ exemplo.com.br mail@exemplo.com.br"
	echo ""
	echo "-i). - Instala Certbot"
	echo "-n). - Novo certificado"
	echo "-r). Renova certificado"
	echo "--ssl). Ativa SSL on apache."
	echo "-h). Exibe essa sjuda."
	echo ""

}
case $1 in
        -i) INSTALLCERTBOT;;
        -n) NEWCERTIFY;;
        -r) RENEWCRTFY;;
        --ssl) SSLON;;
        -h) HELP;;
        *) HELP;;
esac

