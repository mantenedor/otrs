#!/bin/bash

apt-get update && apt-get install -y apache2 default-mysql-client libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl libnet-ldap-perl libio-socket-ssl-perl libpdf-api2-perl libdbd-mysql-perl libsoap-lite-perl libtext-csv-xs-perl libjson-xs-perl libapache-dbi-perl libxml-libxml-perl libxml-libxslt-perl libyaml-perl libarchive-zip-perl libcrypt-eksblowfish-perl libencode-hanextra-perl libmail-imapclient-perl libtemplate-perl libmoo-perl libjavascript-minifier-xs-perl libdatetime-perl libcss-minifier-xs-perl libauthen-ntlm-perl libdbd-odbc-perl

hostname otrs
hostname > /etc/hostname

cd /opt/ && time wget https://download.znuny.org/releases/znuny-latest-6.0.tar.gz && tar -xzvf znuny-latest-6.0.tar.gz && ln -s znuny-6.0.46/ otrs

perl /opt/otrs/bin/otrs.CheckModules.pl && perl -MCPAN -e shell;

useradd -d /opt/otrs -c 'OTRS user' otrs
usermod -G www otrs
cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm
perl -cw /opt/otrs/bin/cgi-bin/index.pl
perl -cw /opt/otrs/bin/cgi-bin/customer.pl
perl -cw /opt/otrs/bin/otrs.Console.pl
ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/apache2/sites-enabled/zzz_otrs.conf
a2enmod perl
a2enmod version
a2enmod deflate
a2enmod filter
a2enmod headers
/etc/init.d/apache2 start
cd /opt/otrs/
bin/otrs.SetPermissions.pl
