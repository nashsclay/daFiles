#1/bin/bash
sudo apt-get update
sudo apt update
sudo apt-get -y upgrade
sudo apt -y upgrade
sudo apt-get -y install build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev 
git clone https://github.com/GivesOfficial/Gives-Source.git
cd Gives-Source/src
sudo make -f makefile.unix



