import boto3    

session = boto3.Session(profile_name="dknopp-mk")
ec2client = session.client("ec2")

# list instances running instances and print their Name Tag
def list_instances(ec2client):
  response = ec2client.describe_instances()
  for reservation in response["Reservations"]:
      for instance in reservation["Instances"]:
        instance_id = instance["InstanceId"]
        #print("found instance {}".format(instance["InstanceId"]))
        if instance["State"]["Name"] != "running":
          continue
          
        print("{} is running".format(instance_id))
        tags = instance['Tags']
        print("{} has {} tags".format(instance_id, len(tags)))
        for tag in tags:
          key = tag['Key']
          if (key == 'Name'):
            value = tag['Value']
            print("Name is {}".format(value))

list_instances(ec2client)