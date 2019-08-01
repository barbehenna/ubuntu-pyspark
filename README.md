# Readme

This docker image is designed to be a platform for the PrairieLearn autograder for UIUC STAT 480. It is based on Ubuntu 18.04 and comes with Apache Spark, Hadoop, Python 3.7, and the following python packages:

- numpy  
- pandas  
- pyarrow
- scipy  
- scikit-learn  
- matplotlib  
- seaborn 
- sqlalchemy  
- azure
- s3fs
- boto3

Additionally, Jupyter is installed for running notebooks and as a first step towards using nbgrader for grading notebook submissions. 
