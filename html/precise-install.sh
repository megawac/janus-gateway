sudo add-apt-repository ppa:gstreamer-developers/ppa
sudo apt-get update
sudo apt-get install aptitude \
        gstreamer0.10 "gstreamer0.10-plugins-*"

rosdep update

# https://core.fluendo.com/gstreamer/trac/wiki/HowToBuildFromSvn

# Websocket dep
sudo aptitude install libevent-dev

cd ~/Downloads
wget http://downloads.xiph.org/releases/ogg/libogg-1.3.1.tar.gz
wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz

# libogg (opus dep)
tar -zxvf libogg-1.3.1.tar.gz
cd libogg-1.3.1
./configure --prefix=/usr
make
sudo make install
cd /usr/lib
cp libogg.so.0.8.0 x86_64-linux-gnu/
sudo ldconfig

# Opus
tar -zxvf opus-1.0.3.tar.gz
cd opus-1.0.3
./configure --prefix=/usr
make
sudo make install


sudo aptitude install libmicrohttpd-dev libjansson-dev libnice-dev \
        libssl-dev libsrtp-dev libsofia-sip-ua-dev libglib2.0-dev \
        libopus-dev libogg-dev libini-config-dev libcollection-dev \
        pkg-config gengetopt doxygen graphviz

sh autogen.sh
./configure --prefix=/opt/janus # Everything checks out
sudo make && sudo make install
sudo make configs

/opt/janus/binjanus --debug-level=5 
