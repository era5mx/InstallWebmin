#!/bin/bash
#
# David Rengifo <david@rengifo.mx> - Junio 2015
# Basado en el script de: Vittorio Franco Libertucci - May 2015
#
# v1.0
# Requires VM extensions
# Install Webmin (http://www.webmin.com/)
# Webmin es una herramienta de configuracion de sistemas accesible via web para sistemas Unix
#############################################################################################

echo "Ejecuto InstallWebmin"

#########################
#                       #  
# Verify distro         #
#                       #
#########################

which python  > /dev/null 2>&1
python_status=`echo $?`  

#echo $python_status

timest=`date +%d-%h-%Y_%H:%M:%S`

if [ "${python_status}" -eq 0 ];  then
#       echo "python is installed"
        distro=`python -c 'import platform ; print platform.dist()[0]'`
        
		date
        echo "VM `uname -n` - Linux distro" $distro
                echo "                    ."
else
        distro=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')

echo $distro
fi

#####

# Jalando los repositorios de Webmin
echo "Jalando los repositorios de Webmin"
cd /opt
wget http://www.webmin.com/jcameron-key.asc
wget  http://www.webmin.com/download/rpm/webmin-current.rpm

#instalando prerrequisito de Webmin
echo "instalando prerrequisito de Webmin"
yum install perl-Net-SSLeay

# Importando los paquetes
echo "Importando los paquetes"
rpm --import jcameron-key.asc

# Instalando Webmin
echo "Instalando Webmin"
rpm -Uvh webmin-*.rpm

sleep 5

#Cambiar el Password de root de la maquina
#passwd root
echo "root:{AQUI_COLOCO_EL_PASSWORD}" | chpasswd 

#poner EL_PASSWORD donde se indica {AQUI_COLOCO_EL_PASSWORD}


####### 
# Hay que configurar el Extremo 10000 en el servidor para disponer la administracion via web
# administrar ya por ip https://ipdelserver:10000
# con user y password root
