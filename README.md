# Readme

This docker image is designed to be a platform for the PrairieLearn autograder for UIUC STAT 480. It is based on Ubuntu 18.04 and comes with Apache Spark 3.0.1, Hadoop 3.2.2, Python 3.7, and the following python packages:

- numpy
- pandas
- sqlalchemy
- scipy
- scikit-learn

This image is hosted on DockerHub as `stat480/pl` and is built automatically whenever there is a new commit to the main branch.

There are a two extra jars included in this repo that are not currently used. They were historically used to help connect to Azure data lakes and may need to be updated before they are reincorporated in future versions of the Docker image.
