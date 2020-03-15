#!/bin/bash

# if service is NodePort and you want to access outside cluster, remember to setup proxy
# microk8s.kubectl port-forward service/dmk-spark-livy 8998:8998 --address 0.0.0.0

clusterIp=192.168.64.4
curl -k -H 'Content-Type: application/json' -X POST -d '{
          "conf": {
             "spark.kubernetes.container.image.pullPolicy": "Always",
             "spark.kubernetes.authenticate.driver.serviceAccountName": "default"
         },
         "file": "local:///opt/spark/examples/jars/spark-examples_2.11-2.4.3.jar",
          "className": "org.apache.spark.examples.SparkPi"
       }' http://"${clusterIp}":8998/batches
