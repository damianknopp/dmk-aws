#!/bin/bash

# if service is NodePort and you want to access outside cluster, remember to setup proxy
# microk8s.kubectl port-forward service/dmk-spark-livy 8998:8998 --address 0.0.0.0
# microk8s.kubectl port-forward service/dmk-spark-webui 8080:8080 --address 0.0.0.0
# cp jar into master
# microk8s.kubectl cp dmk-spark-demo-1.0-SNAPSHOT.jar dmk-spark-master-f5d4c8dd-z2mxq:/opt/spark/examples/jars/.

clusterIp=192.168.64.4
curl -k -H 'Content-Type: application/json' -X POST -d '{
        "conf": {
           "spark.kubernetes.container.image.pullPolicy": "Always",
           "spark.kubernetes.authenticate.driver.serviceAccountName": "default"
        },
        "file": "local:///opt/spark/examples/jars/dmk-spark-demo-1.0-SNAPSHOT.jar",
        "className": "dmk.spark.demo.SimpleApp",
        "args" : [ "/opt/spark/conf/log4j.properties" ],
        "numExecutors": 2,
        "executorCores": 1,
        "executorMemory": "1g"
       }' http://"${clusterIp}":8998/batches
