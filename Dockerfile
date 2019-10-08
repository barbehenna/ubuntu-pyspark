# Copyright (c) Alton Barbehenn.
# In part based on the Jupyter Development Team's jupyter/pyspark-notebook 
# (accessed on DockerHub July 9, 2019)

FROM ubuntu:18.04


MAINTAINER barbehe2@illinois.edu


USER root
# ENV DEBIAN_FRONTEND noninteractive


# Needed to properly handle UTF-8
ENV PYTHONIOENCODING=UTF-8


# relevant versions to install
ENV APACHE_SPARK_VERSION 2.4.4
ENV HADOOP_VERSION 2.7


# Install Java 8 JDK and other prerequisites
# Also install python 3.7
RUN apt-get update && \
	apt-get install -y --no-install-recommends apt-utils
RUN apt-get update --fix-missing 
RUN apt-get install -y openjdk-8-jdk \
	software-properties-common \
	python3.7 python3-pip python3.7-dev \
	sudo \
	make \
	wget


# Set up Python 3.7 and set it as default python3 and python
RUN ln -sf /usr/bin/python3.7 /usr/bin/python3 && \
	ln -s /usr/bin/python3.7 /usr/bin/python && \
	ln -s /usr/bin/pip3 /usr/bin/pip


# Install native Hadoop library
ENV HADOOP_NATIVE_VERSION 2.7.7
RUN cd /tmp && \
	wget -q https://www-us.apache.org/dist/hadoop/common/hadoop-${HADOOP_NATIVE_VERSION}/hadoop-${HADOOP_NATIVE_VERSION}.tar.gz && \
	tar xzf hadoop-${HADOOP_NATIVE_VERSION}.tar.gz -C /usr/local/ && \
	ln -s /usr/local/hadoop-${HADOOP_NATIVE_VERSION} /usr/local/hadoop && \
	rm hadoop-${HADOOP_NATIVE_VERSION}.tar.gz


# Set enviromental variables 
ENV HADOOP_HOME /usr/local/hadoop
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native:$LD_LIBRARY_PATH
ENV PATH $HADOOP_HOME/bin:$PATH


# Install Spark and Hadoop 
# starting from https://spark.apache.org/downloads.html
RUN cd /tmp && \
    wget -q https://www.apache.org/dist/spark/spark-${APACHE_SPARK_VERSION}/spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    echo "2E3A5C853B9F28C7D4525C0ADCB0D971B73AD47D5CCE138C85335B9F53A6519540D3923CB0B5CEE41E386E49AE8A409A51AB7194BA11A254E037A848D0C4A9E5 *spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" | sha512sum -c - && \
    tar xzf spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local --owner root --group root --no-same-owner && \
    rm spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN cd /usr/local && ln -s spark-${APACHE_SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark


# Set enviromental variables 
ENV SPARK_HOME /usr/local/spark
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip
ENV PATH $SPARK_HOME/bin:$PATH


# Copy custom jars to enable Spark-Azure connection
COPY jars/* $SPARK_HOME/jars/


# Get list of python libraries
COPY requirements.txt /


# Install python libraries
RUN python3 -m pip install --no-cache-dir -r /requirements.txt


# Start notebook with `jupyter notebook --ip=0.0.0.0`


# Add user for autograder (like the prairielearn/centos7-python image)
RUN useradd ag

