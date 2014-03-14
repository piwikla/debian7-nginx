#!/bin/bash

#https://github.com/xiaoq-in/debian7-nginx

#Add Dotdeb
echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg 
apt-key add  dotdeb.gpg

#Update
apt-get update
apt-get upgrade
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker  

#Install Nginx
apt-get install -y nginx-full

#Install MySQL
apt-get install -y mysql-server mysql-client
mysql_secure_installation

#Install PHP 
apt-get install -y php5-fpm php5-gd php5-mysql php5-memcache php5-curl memcached

#Install PECL
apt-get install php5-geoip php5-dev libgeoip-dev
pecl install geoip

#Basic Security
apt-get install fail2ban iptables-persistent

#Start Nginx
service nginx start
