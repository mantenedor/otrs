FROM httpd

#COPY ./web/html /usr/local/apache2/htdocs/
#COPY ./web/conf/httpd.conf /usr/local/apache2/conf/httpd.conf
#COPY ./web/conf/httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
#CMD ["bash"]
#RUN sed -i -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' conf/httpd.conf
RUN mkdir /opt/scripts 
COPY scripts /opt/scripts
RUN cd /opt/scripts && ./build.sh
