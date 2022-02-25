#!/bin/bash
cd /home/certel/
export https_proxy="https://user:passwd.@proxy.dominio.com.br:porta"
export http_proxy="http://user.passwd.@proxy.dominio.com.br:porta"
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 root@ip_servidor:diretorio/subdiretorio/ubuntuArq .
cd ubuntuArq/
sh Cria_ubuntu_20_04.sh
