{ resources, ... }:
{
  deployment.targetEnv = "ec2";
  deployment.ec2.accessKeyId = "default";
  deployment.ec2.ami = "ami-2bd87953";
  deployment.ec2.region = "us-west-2";
  deployment.ec2.instanceType = "m1.small";
  deployment.ec2.securityGroups = [ "allow-ssh" "allow-http" ];
  deployment.ec2.keyPair = resources.ec2KeyPairs.my-key-pair;
}

