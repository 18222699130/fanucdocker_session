#!/bin/bash
#first install mysql
echo first step:install mysql
echo begin to add the respository with old version mysql-5.6 href
echo ===========================================================================
apt-get -y install software-properties-common
add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'
echo begin to update the dpkg
apt-get update
#install the mysql-5.6 with no-interactive way
#echo "mysql-server-5.6 mysql-server/root_password fanuc123 root" | debconf-set-selections
#echo "mysql-server-5.6 mysql-server/root_password_again fanuc123 root" | debconf-set-selections
#apt-get -y install mysql-server-5.6 mysql-client-5.6
#maybe this way will not work, you can try this strategy
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server-5.6
service mysql start
mysql -h127.0.0.1 -P3306 -uroot -e"UPDATE mysql.user SET password = PASSWORD('fanuc123') WHERE user = 'root'"


#second download the code and database
echo second step:starting download the code and the database
echo ===========================================================================
git clone https://github.com/zishan11/fanucdocker_session.git
cd fanucdocker_session
apt-get -y install unzip
unzip network_coding.zip


#third is alone scipt
echo third step:install expect
echo ===========================================================================
apt-get -y install expect
chmod 700 config_mysql.sh
./config_mysql.sh


#fourth, install the pip3 and other pypi packages
echo fourth step:install pip3 and other pypi packages
echo ===========================================================================
apt-get -y install python3-pip
pip3 install pymysql
pip3 install python-Levenshtein

#fifth, mkdir a dicretory
echo fifth step:mkdir the log dicretory
echo ===========================================================================
mkdir /var/log/safetyLog

#sixth, we run the code in a screen
echo sixth step:run the code
echo ===========================================================================
screen -dmS FANUCPOT
screen -r FANUCPOT
cd network_coding
python3 NC_TCPserver.py

