#!/bin/sh
#Version: V1.0
#Author: f1ower
#Description: Proxy for build V8 on Ubuntu.
#LICENSE: GNU General Public License v2.0

# install ssr and polipo.
sudo apt-get install libsodium-dev curl polipo
wget https://raw.githubusercontent.com/the0demiurge/CharlesScripts/master/charles/bin/ssr
sudo mv ssr /usr/local/bin
sudo chmod +x /usr/local/bin/ssr
ssr install
ssr config
# Modify polipo configuration files.
sudo sh -c "echo \"socksParentProxy = \"127.0.0.1:1080\"\nsocksProxyType = socks5\" >> /etc/polipo/config"
sudo service polipo restart
sudo service polipo status
