
echo -e "\e[36m Démarrage de l'installation ... "
echo -e "\e[33m Installation des dépendances gérées par linux."

sudo apt-get install -y build-essential freeglut3-dev libompl-dev liborocos-kdl-dev libbotan-2-dev libzbar-dev libxrandr-dev libxaw7-dev libzzip-dev qt5-default libpcl-dev libassimp-dev nvidia-cuda-dev git libqt5serialport5-dev qt5-default cmake curl

echo -e "\e[33m Installation de git LFS..."
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

sudo apt-get -y install git-lfs

echo -e "\e[32m Installation des dépendances gérées par linux réussie."

echo -e "\e[33m Téléchargement des libraires non-gérées par linux"
echo -e "\e[36m"
git clone https://github.com/OGRECave/ogre.git && git clone https://github.com/opencv/opencv.git && git clone https://github.com/lvklabs/QSsh.git && git clone https://github.com/opencv/opencv_contrib.git


if [ -d "ogre-master" ]; then
echo -e "\e[33m Système de simulation déjà installer."
else
echo -e "\e[33m Installation du système de simulation."
echo -e "\e[36m"


echo -e "\e[33m Installation du système de simulation."
echo -e "\e[36m"

#INSTALLATION ORGRE
cd ogre 
cmake . -DOGRE_BUILD_COMPONENT_OVERLAY_IMGUI=off -DOGRE_CONFIG_ENABLE_ZIP=off
make
sudo make install

fi


echo -e "\e[32m Installation du simulateur réussie."

echo -e "\e[33m Installation du système de vision."
echo -e "\e[36m"

#INSTALLATION OPENCV
cd ../
cd opencv
mkdir build 
cd build
cmake ../ -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -LAH && make 
sudo make install
cd ../../
echo -e "\e[32m Installation des systèmes de vision réussie."

echo -e "\e[33m Installation du système de gestion des fichiers."
echo -e "\e[36m"

#INSTALLATION QSsh
cd QSsh
qmake qssh.pro
make 
cd lib
sudo cp libQSsh.so /usr/lib && cp libQSsh.so.1 /usr/lib && cp libQSsh.so.1.0 /usr/lib && cp libQSsh.so.1.0.0 /usr/lib
cd ../
echo -e "\e[32m Installation du système de gestion des fichiers réussie."

#Ne pas oublier de faire un export $SFTP = dossier QSsh
echo -e "\e[33m Mise  à jour des liens du système."
sudo ldconfig

#installation KMeleon
echo -e "\e[33m Téléchargement et installation de KMeleon."
echo -e "\e[36m"

git clone https://florian.dordain@tesseract-solutions.fr:Amiens2017!@github.com/KMeleon-Team/KMInstaller.git
echo -e "\e[32m Téléchargement de KMeleon réussi."
echo -e "\e[33m Installation de KMeleon."
echo -e "\e[36m"
tar xvf KMInstaller-master
echo -e "\e[32m Installation de KMeleon réussi."

#installation UEYE
echo -e "\e[33m Installation des drivers de caméra."
echo -e "\e[36m"

cd ..
cd KMInstaller-master && git lfs checkout && git lfs fetch && sudo sh ueye_4.93.0.989_amd64.run


#options 
#git clone https://github.com/FreeOpcUa/freeopcua.git

#cmake sans les exemples et sans overlay imgui et probablement désactiver le ENABLE_ZIP et supprimer les ZIP du fichier ressources
#Trouver  un moyen pour setter le dossier settings dans le dossier release



