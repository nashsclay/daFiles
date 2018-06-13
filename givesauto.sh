#1/bin/bash
sudo apt-get update
sudo apt update
sudo apt-get -y upgrade
sudo apt -y upgrade
sudo apt-get -y install build-essential libssl-dev libdb++-dev libboost-all-dev libqrencode-dev 
git clone https://github.com/GivesOfficial/Gives-Source.git
cd Gives-Source/src

#change j2 to how many cores you want to use, if 4, then do j4
sudo make -j2 -f makefile.unix



