#!/bin/bash

eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)

shutdown(){
    echo "*** Beginning tomcat shutdown *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    /usr/local/tomcat/bin/catalina.sh stop
    echo "*** Stopped Tomcat process *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    exit 0
}
success(){
    echo "*** Exit 0 | Graceful shutdown *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    echo " ********************************* ">> /home/LogFiles/shutdown.txt
}
trap shutdown 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
trap success 0
echo "Starting ssh as user: $(whoami)"
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''; \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
/usr/sbin/sshd
echo "startup pid is: $$"
echo "Starting tomcat process as tomcat user in bg (sigterm trap)"
sudo -u tomcat  /usr/local/tomcat/bin/catalina.sh run &
PID=$!
echo "Tomcat process pid : $!"
wait $PID














