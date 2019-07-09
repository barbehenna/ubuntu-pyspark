# Copyright (c) Alton Barbehenn.
# Based on the Jupyter Development Team's jupyter/pyspark-notebook 
# on DockerHub July 9, 2019

FROM ubuntu:18.04

USER root
ENV DEBIAN_FRONTEND noninteractive

# relevant versions to install
ENV APACHE_SPARK_VERSION 2.4.3
ENV HADOOP_VERSION 2.7

# Install Java 8 JDK and other prerequisites
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
RUN apt-get update --fix-missing 
RUN apt-get install -y openjdk-8-jdk \ 
	software-properties-common \ 
	wget

# Install Python 3.7 and set it as default python3 and python
RUN apt-get install -y python3.7 python3-pip && \ 
	ln -sf /usr/bin/python3.7 /usr/bin/python3 && \ 
	ln -s /usr/bin/python3.7 /usr/bin/python && \ 
	ln -s /usr/bin/pip3 /usr/bin/pip

# Install Spark and hadoop 
# starting from https://spark.apache.org/downloads.html
RUN cd /tmp && \ 
    wget -q http://mirror.cogentco.com/pub/apache/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \ 
    echo "E8B7F9E1DEC868282CADCAD81599038A22F48FB597D44AF1B13FCC76B7DACD2A1CAF431F95E394E1227066087E3CE6C2137C4ABAF60C60076B78F959074FF2AD *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \ 
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local --owner root --group root --no-same-owner && \ 
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark

# Set enviromental variables 
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip

# Install python libraries
RUN pip install numpy \ 
	pandas \ 
	scipy \ 
	scikit-learn \ 
	matplotlib \ 
	seaborn \ 
	sqlalchemy \ 
	jupyter 

# Change user from root 
# This let's us use jupyter notebooks without a `--allow-root` flag
# Start notebook with `jupyter notebook --ip=0.0.0.0`
USER $NB_UID





