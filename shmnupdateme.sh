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
sudo make -j4 HOST=x86_64-w64-mingw32
cd ..
chmod +x autogen.sh
sudo ./autogen.sh
chmod +x configure && chmod +x share/genbuild.sh && chmod +x src/leveldb/build_detect_platform
sudo ./configure --with-gui=qt5 --prefix=`pwd`/depends/x86_64-w64-mingw32 --enable-static
sudo make
