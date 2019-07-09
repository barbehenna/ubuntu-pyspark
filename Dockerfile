# Copyright (c) Alton Barbehenn.
# Based on the Jupyter Development Team's jupyter/pyspark-notebook 
# on DockerHub July 9, 2019

FROM ubuntu:18.04

USER root

# relevant versions to install
ENV APACHE_SPARK_VERSION 2.4.3
ENV HADOOP_VERSION 2.7

# Install Java 8 JDK
RUN apt-get update --fix-missing
RUN apt-get install -y openjdk-8-jdk




