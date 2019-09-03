package dmk.ec2.client;

import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.ec2.Ec2AsyncClient;
import software.amazon.awssdk.services.ec2.Ec2AsyncClientBuilder;
import software.amazon.awssdk.services.ec2.model.Instance;
import software.amazon.awssdk.services.ec2.model.InstanceType;
import software.amazon.awssdk.services.ec2.model.RunInstancesRequest;
import software.amazon.awssdk.services.ec2.model.RunInstancesResponse;

import java.util.List;

public class EC2CreateClient {

    private EC2CreateClient() {
        super();
    }

    private void init(String profile) throws Exception {
        AwsCredentialsProvider credsProvider = ProfileCredentialsProvider
                .create(profile);
        Ec2AsyncClientBuilder builder = Ec2AsyncClient.builder()
                .credentialsProvider(credsProvider)
                .region(Region.US_EAST_1);
        Ec2AsyncClient ec2 = builder.build();
        System.out.println(ec2.toString());
//        Ec2Client ec2 = Ec2Client.create();
        String amiLinux2 = "ami-0b898040803850657";
        RunInstancesRequest run_request = RunInstancesRequest.builder()
                .imageId(amiLinux2)
                .instanceType(InstanceType.T1_MICRO)
                .maxCount(1)
                .minCount(1)
                .build();

        RunInstancesResponse response = ec2.runInstances(run_request).get();
        List<Instance> instances = response.instances();
        instances.forEach(instance -> {
            System.out.println(instance.instanceId());
        });


    }

    public static void main(String ...args) throws Exception {
        System.out.println("EC2 Client Driver");
        EC2CreateClient driver = new EC2CreateClient();
        String profileName = args.length > 0 ? args[0] : "default";
        driver.init(profileName);
    }
}
