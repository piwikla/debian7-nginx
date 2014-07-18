#!/bin/bash

#https://github.com/piwikla/debian7-nginx

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

#LOAD DATA INFILE
apt-get install php5-mysqlnd

#Install phpMyAdmin
apt-get install phpmyadmin
sudo ln -s /usr/share/phpmyadmin/ /home/piwik/public_html/piwik.la

#config nginx
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/piwik.la
ln -s /etc/nginx/sites-available/piwik.la /etc/nginx/sites-enabled
rm /etc/nginx/sites-enabled/default

#download piwik
mkdir -p /home/piwik/public_html/piwik.la
cd /home/piwik/public_html/piwik.la
wget http://piwik.org/latest.zip && unzip piwik.zip
rm How\ to\ install\ Piwik.html
cd piwik
mv * ../
cd ../
rm -rf piwik piwik.zip
sudo chown -R www-data:www-data /home/piwik/public_html/piwik.la
sudo chmod 755 /home/piwik/public_html

#Basic Security
apt-get install fail2ban iptables-persistent

#Remove Apache2
apt-get remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-mpm-prefork apache2-doc apache2-mpm-worker  

#Restart Service
sudo service php5-fpm restart
sudo service nginx restart
sudo service mysql restart
