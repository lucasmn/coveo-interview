#!/bin/bash

# This script handles all the dependencies necessary to execute the producer application, including starting an AWS Kinesis Stream to receive data from the producer #


sudo yum install python37

curl -O https://bootstrap.pypa.io/get-pip.py

python3 get-pip.py --user

rm get-pip.py

pip install awscli

aws kinesis create-stream --stream-name cov-interview-input-stream --shard-count 1 --region us-east-1

pip install boto3

mkdir sample_data

curl -O https://cov-interview-sample-data.s3.amazonaws.com/searches.csv

mv searches.csv sample_data
