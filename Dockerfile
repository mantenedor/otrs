FROM httpd

RUN apt-get update && apt-get install -y time wget iputils-ping htop vim ca-certificates telnet cron jq
RUN apt -y install mariadb-client cpanminus libapache2-mod-perl2 libdbd-mysql-perl libtimedate-perl libnet-dns-perl libnet-ldap-perl libio-socket-ssl-perl libpdf-api2-perl libsoap-lite-perl libtext-csv-xs-perl libjson-xs-perl libapache-dbi-perl libxml-libxml-perl libxml-libxslt-perl libyaml-perl libarchive-zip-perl libcrypt-eksblowfish-perl libencode-hanextra-perl libmail-imapclient-perl libtemplate-perl libdatetime-perl libmoo-perl bash-completion libyaml-libyaml-perl libjavascript-minifier-xs-perl libcss-minifier-xs-perl libauthen-sasl-perl libauthen-ntlm-perl libhash-merge-perl libical-parser-perl libspreadsheet-xlsx-perl libcrypt-jwt-perl libcrypt-openssl-x509-perl jq libcrypt-jwt-perl libspreadsheet-xlsx-perl libical-parser-perl libhash-merge-perl libcrypt-openssl-x509-perl libcrypt-jwt-perl libcpan-audit-perl libhash-merge-perl libical-parser-perl libdata-uuid-perl
RUN cpanm install Jq
RUN cd /opt/ && time wget https://download.znuny.org/releases/znuny-6.5.3.tar.gz && tar -xzvf znuny-6.5.3.tar.gz && ln -s /opt/znuny-6.5.3/ /opt/otrs
RUN sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' -e '/^LoadModule mpm_event_module modules\/mod_mpm_event.so/s/^/#/' -e '/^#LoadModule mpm_prefork_module modules\/mod_mpm_prefork.so/s/^#//' -e 's/^#\(LoadModule .*mod_cgi.so\)/\1/'  -e 's/^#\(LoadModule .*mod_deflate.so\)/\1/' -e 's/^#\(LoadModule .*mod_filter.so\)/\1/' -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' /usr/local/apache2/conf/httpd.conf
RUN echo "Include conf/extra/zzz_znuny.conf" >> /usr/local/apache2/conf/httpd.conf 
RUN echo "LoadModule perl_module /usr/lib/apache2/modules/mod_perl.so" >> /usr/local/apache2/conf/httpd.conf
RUN perl /opt/otrs/bin/otrs.CheckModules.pl
RUN useradd -d /opt/otrs -c 'Znuny user' -g www-data -s /bin/bash -M -N otrs
RUN cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm
RUN /opt/otrs/bin/otrs.SetPermissions.pl
RUN ln -s /opt/otrs/scripts/apache2-httpd.include.conf /usr/local/apache2/conf/extra/zzz_znuny.conf
RUN su - otrs && cd /opt/otrs/var/cron && for foo in *.dist; do cp $foo `basename $foo .dist`; done