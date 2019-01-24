#!/usr/bin/expect  -f     
spawn mysql -u root -h 127.0.0.1 -p
expect "Enter password: "
send "fanuc123\r\n"
expect eof
send "create fanucdocker;\r\n"
send "use fanucdocker;\r\n"
send "source ~/fanucdocker_session/fanucdocker_session.sql;\r\n"	
