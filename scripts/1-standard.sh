#!/bin/bash
echo "Atualizando pacotes..."
apt-get update
apt-get install -y time wget iputils-ping htop vim ca-certificates systemd telnet cron
