#!/bin/bash
MAIN_FOLDER=~/Library/"Application Support"/Electra
clear
echo
echo -e ECA User Support Fix-o-Lot v1.0
echo -e Last Updated: May 13, 2018
echo
echo Downloading latest peers.dat file
echo
curl -L -o peers.dat "https://drive.google.com/uc?export=download&id=${11zPKIT_UCUgxQPYdVXykfM6fKZohKEz4}"
echo
echo -e Checking for Electra folder, please wait...
sleep 2
if [ -d "$MAIN_FOLDER" ];
   then
      echo
      echo Electra folder found
      echo
      read -p "Press any key to close your current wallet and continue..."
      killall -9 Electra-qt >/dev/null 2>&1
      killall -9 Electrad >/dev/null 2>&1
      echo
      echo Copying peers.dat to "$MAIN_FOLDER"
      yes | cp -rf ./peers.dat "$MAIN_FOLDER"/peers.dat
      sleep 1
      echo
      echo Copying peers.dat complete
      echo
      echo Now restart your wallet
      echo
      read -p "Press any key to quit"
      echo
      clear
      exit 1
   else
      echo
      echo Electra folder does not exist in "$MAIN_FOLDER" ...
      echo
      read -p "Press any key to quit"
      echo
      clear
      exit 1
fi
