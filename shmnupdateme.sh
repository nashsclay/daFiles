#!/bash/bin
sudo add-apt-repository "deb http://old-releases.ubuntu.com/ubuntu zesty universe"
sudo apt-get update
sudo apt update
sudo apt-get -y upgrade
sudo apt -y upgrade
sudo apt -y install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git
sudo apt -y install g++-mingw-w64-x86-64
PATH=$(echo "$PATH" | sed -e 's/:\/mnt.*//g')
sudo chmod 777 -R *
cd depends
