#!/bin/bash
echo "************** Starting ssh as user  ******************" 
echo $whoami
service sshd start
su - tomcat
echo "************** Starting tomcat as user ******************" 
echo $whoami
/usr/local/tomcat/bin/catalina.sh run