#!/bin/bash
touch /home/LogFiles/shutdown.txt
shutdown(){
    echo "*** Beginning tomcat shutdown *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    /usr/local/tomcat/bin/catalina.sh stop
    echo "*** Stopped Tomcat process *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    exit 0
}
success(){
    echo "Successfully stopped tomcat process"
    echo "*** Exit 0 | Graceful shutdown *****" >> /home/LogFiles/shutdown.txt
    echo $(date) >> /home/LogFiles/shutdown.txt
    echo " ********************************* ">> /home/LogFiles/shutdown.txt
}
trap shutdown 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
trap success 0
echo "************** Starting ssh as user $(whoami) ******************" 
echo "startup pid is $$"
echo "Starting tomcat process in bg"
/usr/local/tomcat/bin/catalina.sh run &
PID=$!
echo "Tomcat process pid : $!"
wait $PID













