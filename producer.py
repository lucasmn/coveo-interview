import json
import boto3
import csv
import time

""" 
    This script reads from a sample data file and 
    injects rows as a JSON object into a AWS Kinesis Stream
""" 


kinesis = boto3.client('kinesis', region_name='us-east-1')

with open('./sample_data/searches.csv', 'rt') as my_file:
    csv_reader = csv.DictReader(my_file, escapechar='\\')

    for row in csv_reader:
     print(row)
     kinesis.put_record(
                StreamName="cov-interview-input-stream",
                Data=json.dumps(row),
                PartitionKey="partitionkey") # Using dummy key - example stream has only 1 shard
     time.sleep(10)
