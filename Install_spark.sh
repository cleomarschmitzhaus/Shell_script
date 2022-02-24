#!/bin/bash

# Script criado para rodar em Linux Ubuntu 20.04 LTS
# Install Spark 2.9.4

# Declarativas de variáveis de ambiente para proxy em linux
export https_proxy="https://user:passwd.@proxy.dominio.com.br:porta"
export http_proxy="http://user.passwd.@proxy.dominio.com.br:porta"

# Atualização, instalação do "vim" e "java default-jre"
apt update && apt install vim && apt install default-jre -y

cd Downloads/

# Copia do arquivo tar.gz do servidor
# Servidor antigo com criptografia sha1 ativa
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 root@ip_servidor:/caminho_do_arquivo/subdiretorio/spark_2_9_4.tar.gz .

# Script shell para chamar o programa
scp -oKexAlgorithms=+diffie-hellman-group1-sha1 root@ip_servidor:/caminho_do_arquivo/subdiretorio/spark.sh

# Mover arquivo para o diretório /Desktop
mv spark.sh /home/$USER/'Área\ de\ Trabalho/'

# Tornar o arquivo imutável
chattr +i /home/$USER/'Área\ de\ Trabalho/'spark.sh

# Extrair, remover pasta antiga e mover pasta nova do programa Spark
tar -zxvf spark_2_9_4.tar.gz
rm -rf /opt/spark
mv Spark /opt/
