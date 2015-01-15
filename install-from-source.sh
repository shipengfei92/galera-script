#!/bin/bash

sed -i "s/archive.ubuntu.com/ftp.sjtu.edu.cn/g" /etc/apt/sources.list

apt-get update
apt-get install -y wget
apt-get install -y make g++ gcc git
apt-get install -y scons

if [ ! -d "galera-version_nbr-src/" ];then
	wget https://launchpad.net/galera/2.x/version_nbr/+download/galera-version_nbr-src.tar.gz
	tar zvxf galera-version_nbr-src.tar.gz
fi

git clone https://github.com/codership/galera.git

cd galera-version_nbr-src/

scons

if [ ! -d "mysql-version_nbr/" ];then
	wget http://dev.mysql.com/get/downloads/mysql-version_nbr/mysql-version_nbr.tar.gz
	tar zvxf mysql-version_nbr.tar.gz 
fi

if [ ! -d "mysql-version_nbr.patch" ];then
	wget https://launchpad.net/codership-mysql/version_nbr/+download/mysql-version_nbr.patch.gz
	gunzip mysql-version_nbr.patch.gz
fi

cd mysql-version_nbr/
patch -p0 <../mysql-version_nbr.patch

cmake -DWITH_WSREP=1 \
        -DWITH_INNODB_DISALLOW_WRITES=1

make


