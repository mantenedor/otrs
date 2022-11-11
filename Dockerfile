FROM debian:latest

CMD ["bash"]

RUN apt-get update && apt-get install -y time wget iputils-ping htop vim ca-certificates default-mysql-client systemd 

COPY otrs_install.sh /opt

RUN cd /opt && ./otrs_install.sh
