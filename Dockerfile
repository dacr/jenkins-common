FROM centos:centos7
MAINTAINER David Crosson <crosson.david@gmail.com>

ENV JENKINS_HOME     /var/jenkins_home

RUN mv /etc/localtime /etc/localtime.bak && \
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

RUN   yum -y install git svn
RUN   yum -y install zip unzip
RUN   yum -y install tar
RUN   yum -y install java
RUN   yum -y install maven
RUN   yum -y install ant
RUN   yum -y install python-devel
RUN   yum -y install gcc

RUN   rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm
RUN   yum -y update
RUN   yum -y install python-pip

RUN   pip install --upgrade pip

RUN   pip install shade
RUN   pip install ansible

ENV SBT_LAUNCHER_URL http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/0.13.11/sbt-launch.jar
RUN mkdir -p /opt/sbt/
RUN curl -SL $SBT_LAUNCHER_URL -o /opt/sbt/sbt-launch.jar
ADD sbt /opt/sbt/
RUN echo 'PATH=$PATH:/opt/sbt/' > /etc/profile.d/sbt.sh

RUN useradd -d $JENKINS_HOME -m -s /bin/bash jenkins
RUN mkdir $JENKINS_HOME/logs
RUN usermod -m -d "$JENKINS_HOME" jenkins
RUN chown -R jenkins:jenkins "$JENKINS_HOME"

