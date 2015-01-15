#!/bin/bash

sed -i "s/archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

apt-get update
apt-get install -y psmisc mysql-client
apt-get install -y wget

if [ ! -f "galera-25.3.5-amd64.deb" ];then
	wget https://launchpad.net/galera/3.x/25.3.5/+download/galera-25.3.5-amd64.deb
fi
