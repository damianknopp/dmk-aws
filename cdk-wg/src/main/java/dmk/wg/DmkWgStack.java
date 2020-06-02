package dmk.wg;

import software.amazon.awscdk.core.Construct;
import software.amazon.awscdk.core.Stack;
import software.amazon.awscdk.core.StackProps;
import software.amazon.awscdk.services.ec2.Instance;
import software.amazon.awscdk.services.ec2.InstanceClass;
import software.amazon.awscdk.services.ec2.InstanceSize;
import software.amazon.awscdk.services.ec2.InstanceType;
import software.amazon.awscdk.services.ec2.LookupMachineImage;
import software.amazon.awscdk.services.ec2.Peer;
import software.amazon.awscdk.services.ec2.Port;
import software.amazon.awscdk.services.ec2.SecurityGroup;
import software.amazon.awscdk.services.ec2.Subnet;
import software.amazon.awscdk.services.ec2.SubnetConfiguration;
import software.amazon.awscdk.services.ec2.SubnetSelection;
import software.amazon.awscdk.services.ec2.SubnetType;
import software.amazon.awscdk.services.ec2.UserData;
import software.amazon.awscdk.services.ec2.Vpc;
import software.amazon.awscdk.services.iam.IManagedPolicy;
import software.amazon.awscdk.services.iam.IPrincipal;
import software.amazon.awscdk.services.iam.ManagedPolicy;
import software.amazon.awscdk.services.iam.Policy;
import software.amazon.awscdk.services.iam.PrincipalBase;
import software.amazon.awscdk.services.iam.PrincipalWithConditions;
import software.amazon.awscdk.services.iam.Role;
import software.amazon.awscdk.services.iam.ServicePrincipal;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import static java.lang.String.format;

public class DmkWgStack extends Stack {
    public DmkWgStack(final Construct scope, final String id) {
        this(scope, id,null, "wg-0",null);
    }

    public DmkWgStack(final Construct scope, final String id, final StackProps props, final String baseName, final String userDataScript) {
        super(scope, id, props);


        var subnetConfiguration = SubnetConfiguration
                .builder()
                .name(baseName + "public-subnet")
                .cidrMask(16)
                .subnetType(SubnetType.PUBLIC)
                .build();


        var vpc = Vpc.Builder
                .create(this, baseName + "-vpc")
                .enableDnsHostnames(true)
                .enableDnsSupport(true)
                .maxAzs(1)
                .subnetConfiguration(List.of(subnetConfiguration))
                .build();

//        var subnet = Subnet.Builder
//                .create(this, baseName + "-subnet")
//                .mapPublicIpOnLaunch(true)
//                .vpcId(vpc.getVpcId())
//                .availabilityZone("us-east-1d")
//                .cidrBlock("10.0.0.0/16")
//                .build();

        Number wgPort = 51820;
        var sg = SecurityGroup.Builder
                .create(this, baseName + "-sg")
                .securityGroupName(baseName + "-sg")
                .description(baseName + " security group")
                .allowAllOutbound(true)
                .vpc(vpc)
                .build();
        sg.addIngressRule(Peer.anyIpv4(), Port.udp(wgPort), "allow wire guard udp");
        // use ssm connect instead of ssh
        //  https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html
        //        sg.addIngressRule(Peer.anyIpv4(), Port.tcp(22), "ssh");

        var ec2Image = new Ec2Image(this, baseName + "-ami");
        var ec2ServicePrincipal = ServicePrincipal.Builder
                .create("ec2")
                .region(props.getEnv().getRegion())
                .build();
        var ssmInstanceCore = ManagedPolicy.fromAwsManagedPolicyName("AmazonSSMManagedInstanceCore");
        var ec2FullAccess = ManagedPolicy.fromAwsManagedPolicyName("AmazonEC2FullAccess");
        var role = Role.Builder
                .create(this, baseName + "-ec2-role")
                .roleName(baseName + "-ec2-role")
                .description("instance role for " + baseName)
                .managedPolicies(List.of(ec2FullAccess, ssmInstanceCore))
                .assumedBy(ec2ServicePrincipal)
                .build();
        UserData userData = UserData.forLinux();
        if (userDataScript != null && !userDataScript.isBlank()) {
            userData.addCommands(userDataScript);
        }
        Instance.Builder
                .create(this, baseName + "-compute")
                .instanceName(baseName)
                // t3a.nano
                .instanceType(InstanceType.of(InstanceClass.BURSTABLE3_AMD, InstanceSize.NANO))
                // ubuntu 20.04
                .machineImage(ec2Image.image)
                .role(role)
                // https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.htmlcd
                // .keyName(baseName)
                // schedule on a public vpc,subnet
                .vpc(vpc)
//                .vpcSubnets(subnetSelection)
                .securityGroup(sg)
                // install wireguard
                .userData(userData)
                .build();
    }

    /**
     * Dynamically lookup ubuntu 20.04
     */
    static class Ec2Image extends Construct {

        enum ARCH {
          ARM64, AMD64
        };

        LookupMachineImage image;
        Ec2Image(Construct parent, String name) {
            this(parent, name, ARCH.AMD64);
        }

        Ec2Image(Construct parent, String name, ARCH arch) {
            super(parent, name);
            lookupAmi(name, arch);
        }

        public void lookupAmi(String name, ARCH arch) {
            var archStr = arch.toString().toLowerCase();
            // amd64
            // ubuntu 20.04 in us-east-1 should show
            // amd64 ami-068663a3c619dd892
            // arm64 ami-00579fbb15b954340
            // ["099720109477"] # Canonical
            var owners = List.of("099720109477");
            var filters = Map.of(
                    "name", List.of(format("ubuntu/images/hvm-ssd/ubuntu-focal-*-%s-server-*", archStr)),
                    "virtualization-type", List.of("hvm")
            );

            this.image = LookupMachineImage.Builder
                    .create()
                    .name(name)
                    .owners(owners)
                    .filters(filters)
                    .windows(false)
                    .build();
        }
    }
}
