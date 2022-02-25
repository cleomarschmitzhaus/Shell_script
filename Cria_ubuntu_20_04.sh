#!bin/bash
# Configuração completa de ambiente Ubuntu 20.04 LTS
echo
echo "Iniciando script..."
echo
# Verifica se executou o script como root
if [ $(whoami) != 'root' ]; then
        echo "Você precisa ser root para executar $0 :"     # $0 é o script atual
        echo "Digite: sudo $0"
        exit 1;
fi
echo
# Configurando variaveis de ambiente
echo "Configuração de variáveis de ambiente"
export https_proxy="https://user:passwd.@proxy.dominio.com.br:porta"
export http_proxy="http://user.passwd.@proxy.dominio.com.br:porta"
echo
echo "Atualizando lista de pacotes"
apt update && apt upgrade -y
echo
echo "Instalação do editor de texto vim"
apt install vim -y
echo "Instalando ssh"
apt-get install ssh -y
echo "Gerando a chave ssh"
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
echo
# Verifca se arquivo apt.conf existe
ls -l /etc/apt/apt.conf > /dev/null
if [[ $? != 0 ]]; then
        cp /home/$USER/ubuntuArq/apt.conf /etc/apt/
fi
echo
# Verifica versao da distribuicao
version=$(lsb_release -d | awk '{print $3}')
echo "Versão do Ubuntu: $version"
echo "$version" > version.txt
echo
#posicionamento dentro da pasta ubuntuArq
cd /home/$USER/ubuntuArq
echo
# Wget do pacote Google-Chrome e instalação via apt .deb
echo "Instalação do Google-Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
echo
# instalar o x11vnc
echo "instalação do pacote X11vnc para acesso remoto"
sudo apt-get install x11vnc -y
echo
# Fazer copia do arquivoi "x11vnc.service" ja pronto para o diretório correto.
cp x11vnc.service /etc/systemd/system/
echo
# Permissoes de arquivos"
echo" dar permissoes para o arquivo x11vnc.service"
chmod 777 /etc/systemd/system/x11vnc.service
echo
echo "configurar a senha do vnc"
echo
x11vnc -storepasswd psswd /etc/x11vnc.pass
cp x11vnc.conf /etc/init/
cp ubuntu/vnc.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable vnc.service
systemctl daemon-reload
echo
#Instalação do ambiente gráfico Unity
echo "Instalação do pacote Unity-Desktop"
apt install ubuntu-unity-desktop -y
echo "Libre-Office e NLWeb na area de trabalho"
echo
# Se posicionar na pasta ubuntuArq/
cd /home/$USER/ubuntuArq
echo
cp nl.ico /usr/share/icons/custom/
cp NLWeb.desktop /usr/share/applications/
cd /home/$USER/Área\ de\ Trabalho/
cp /usr/share/applications/libreoffice-startcenter.desktop .
chmod 777 libreoffice-startcenter.desktop
# alterar manualmente o icone do aplicativo
echo
cp /usr/share/applications/google-chrome.desktop .
chmod 777 google-chrome.desktop
echo
cp /home/$USER/ubuntuArq/spark.sh .
chmod 777 spark.sh
chattr +i *
echo
apt install default-jre
cd /home/$USER/ubuntuArq/
tar -zxvf spark_2_9_4.tar.gz
mv Spark /opt/
echo "Finalização do script de configuração Linux Ubuntu 20.04"
