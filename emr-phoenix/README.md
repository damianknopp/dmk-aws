# EMR And CloudFormation

This project demonstrates how to manage an (EMR)[https://aws.amazon.com/emr/] cluster using Cloudformation (CF)[https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html]. The EMR is configured to;

* install hbase, phoenix, hive, pig, spark
* use S3 for data stored in hbase and hive
* use glue as the hive meta store
* not set S3 consistent view (if you set to true, make sure to clean up the DynamoDB table)

## Dependencies
To run these scripts you will need

* an AWS account
* installed [awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* install [aws-vault](https://github.com/99designs/aws-vault)
* configure the environment variables in the bash scripts

```
cp bin/env-template to bin/env.sh
vi bin/env.sh
# modify variables
```

* configure the cloudformation variables, set the s3 base bucket in `cloudformation/emr-phoenix.yml`
## Run

Create a keypair `pem` file to be used by the cluster. This step will create the SSH keypair to be used by the EMR nodes
```
./bin/create-keypair.sh
```

Create the EMR default roles. This step will create the service and job instance profile roles to be used in the EMR cluster
```
./bin/create-emr-default-roles.sh
```

Create the EMR CF stack. This step will create the network components and EMR cluster
```
./bin/create-stack.sh
```

## Destroy
Run the CF template destroy script. This step will destroy all the components created in the `create-stack.sh` step. _Note: There is a bug where the VPC itself might fail to be destroyed, all other components will be destroyed_

```
./bin/delete-stack.sh
```


## Notes

* TODO: refactor the CF template into Network and EMR
* TODO: better document or pass in parameters to the CF template
* TODO: destroy might not destroy the VPC because of a default route table dependency. But all other components are destroyed
* TODO: destroy a dynamodb table if one is created