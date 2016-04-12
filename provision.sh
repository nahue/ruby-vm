#!/bin/bash
echo Provisioning Ruby on Rails...
echo =================================

echo - Installing dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get install curl git -y -qq > /dev/null

echo - Installing mysql server
export DEBIAN_FRONTEND=noninteractive
echo mysql-server-5.1 mysql-server/root_password password progra | debconf-set-selections
echo mysql-server-5.1 mysql-server/root_password_again password progra | debconf-set-selections
apt-get -y install mysql-server
sudo apt-get -y install build-essential libmysqlclient-dev zlib1g-dev ruby-full

echo - Installing postgresql
sudo apt-get install postgresql postgresql-contrib -y -qq > /dev/null
sudo apt-get install libpq-dev -y -qq > /dev/null

echo - Installing other software
sudo apt-get -y install libxslt-dev libxml2-dev
sudo apt-get -y install imagemagick libmagickwand-dev
sudo apt-get -y install nodejs

echo - Install mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update -y -qq > /dev/null
sudo apt-get -y install mongodb-org

echo - Installing RVM and latest Ruby 
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -L https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
# rvm install ruby-2.1.9

echo - Installing Rails
gem install rails --no-ri --no-rdoc

echo - Installing additional gems
gem install bundler
gem install mysql2
gem install pg
gem install rake

rvm -v
ruby -v
gem -v
rails -v