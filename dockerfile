
#docker search registry.access.redhat.com/ubi
FROM registry.access.redhat.com/ubi9
LABEL maintainer="Ragu Karuturi"

#Install java v17 and set env v	ars
RUN yum update -y && yum install -y java-17
ENV JAVA_HOME  /usr/lib/jvm/java-17-openjdk-17.0.5.0.8-2.el9_0.x86_64
ENV PATH $PATH:/usr/lib/jvm/java-17-openjdk-17.0.5.0.8-2.el9_0.x86_64/bin

#Download and install tomcat v10
RUN curl -k https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz -o /tmp/apache-tomcat-10.0.27.tar.gz 

WORKDIR /usr/local
RUN tar -xf /tmp/apache-tomcat-10.0.27.tar.gz -C .
RUN mv apache-tomcat-10.0.27 tomcat
ENV CATALINA_HOME /usr/local/tomcat
WORKDIR /usr/local/tomcat

#Create tomcat user
RUN useradd -d /usr/local/tomcat -U tomcat
RUN chown -R tomcat: /usr/local/tomcat

#Install basic tools. 
RUN yum install procps -y \
	&& yum install net-tools -y \
	&& yum install sudo -y

#Delete existing apps and copy primary build artifact
RUN rm -rf webapps/*
COPY target/cenlinsbw1-0.0.1-SNAPSHOT.war webapps/ROOT.war

#Install and configure ssh
RUN yum install -y openssh-server openssh-clients
RUN echo "root:Docker!" | chpasswd
COPY sshd_config /etc/ssh/

#Custom startup script to launch multiple services when not using supervisord
COPY start.sh .
RUN chmod +x start.sh

#Install EPEL (extra packages for enterprise linux) needed for supervisord
RUN dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y

#Install supervisor. Requires a python runtime. 
RUN yum install -y supervisor

#Expose app and ssh ports
EXPOSE 8080 2222

#Start supervisord in exec mode with PID 1
ENTRYPOINT ./start.sh



