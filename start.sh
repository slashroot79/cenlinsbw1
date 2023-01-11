#!/bin/bash

shutdown(){
    echo "********** Interrupt received...shutting down process *************"
    /usr/local/tomcat/bin/catalina.sh stop
    exit 0
}
success(){
    echo "Successfully stopped tomcat process"
}
trap shutdown 1 2 3 6 9 15
trap success 0
echo "************** Starting ssh as user $(whoami) ******************" 
echo "startup pid is $$"
echo "Starting tomcat process in bg"
/usr/local/tomcat/bin/catalina.sh run &
PID=$!
echo "Tomcat process pid : $!"
wait $PID