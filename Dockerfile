FROM centos:centos7
MAINTAINER David Crosson <crosson.david@gmail.com>

ENV JENKINS_HOME     /var/jenkins_home

RUN mv /etc/localtime /etc/localtime.bak && \
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN   rpm -i http://pkgs.repoforge.org/proxytunnel/proxytunnel-1.9.0-1.el7.rf.x86_64.rpm
RUN   yum -y install git
RUN   yum -y install zip
RUN   yum -y install unzip
RUN   yum -y install java
RUN   yum -y install maven

RUN mkdir -p /opt/sbt/
RUN curl -SL $SBT_LAUNCHER_URL -o /opt/sbt/sbt-launch.jar
ADD sbt /opt/sbt/
RUN echo 'PATH=$PATH:/opt/sbt/' > /etc/profile.d/sbt.sh

RUN useradd -d $JENKINS_HOME -m -s /bin/bash jenkins
RUN mkdir $JENKINS_HOME/logs
RUN usermod -m -d "$JENKINS_HOME" jenkins && chown -R jenkins "$JENKINS_HOME"

