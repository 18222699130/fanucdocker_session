#!/usr/bin/expect  -f     
spawn mysql -u root -p
expect "Enter password: "
send "fanuc123\r\n"
expect eof
send "create database fanucdocker;\r\n"
send "use fanucdocker;\r\n"
send "set names utf8;\r\n"
send "source ~/fanucdocker_session/fanucdocker_session.sql;\r\n"
send "exit\r\n"
expect eof
