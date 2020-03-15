#!/bin/bash

curl -k -H 'Content-Type: application/json' -X POST -d '{
          "conf": {
             "spark.kubernetes.container.image.pullPolicy": "Always",
             "spark.kubernetes.authenticate.driver.serviceAccountName": "default"
         },
         "file": "local:///opt/spark/examples/jars/spark-examples_2.11-2.4.3.jar",
          "className": "org.apache.spark.examples.SparkPi"
       }' http://alb.us-east-1.elb.amazonaws.com:8998/batches
