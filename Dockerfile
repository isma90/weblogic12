FROM ubuntu:18.10

ARG BASE_DIR=/scratch/u01
ARG JDK_COMPRESSED=jdk-8u191-linux-x64.tar.gz
ARG JAVA_FOLDER_NAME=jdk1.8.0.191
ARG JAVA_BASE=$BASE_DIR/$JAVA_FOLDER_NAME
ARG JAVA_HOME=/usr/lib/jvm/jdk

WORKDIR $BASE_DIR

COPY source ./source/$JDK_COMPRESSED ./

RUN mkdir $JAVA_FOLDER_NAME && tar -xvf $JDK_COMPRESSED -C $JAVA_FOLDER_NAME --strip-components 1
RUN rm -rf $JDK_COMPRESSED

RUN mkdir /usr/lib/jvm
RUN ln -s $JAVA_BASE $JAVA_HOME

RUN echo "export JAVA_HOME=$JAVA_HOME" >> /root/.bashrc
RUN echo "export PATH=$PATH:$JAVA_HOME/bin" >> /root/.bashrc

RUN touch /etc/environment
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /etc/environment
RUN echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/environment


CMD ["/bin/bash"]