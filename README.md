# terra_vpc_mariadb

Required:
 Terraform - https://learn.hashicorp.com/terraform/getting-started/install.html
 
 AWS CLI - https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
 
 
 Steps
 1.  Configure your aws keys
 $ aws configure
 2.  Create (if doesn't exist) a EC2 key
 3.  Put the "keyname" and "keypath" in the variables.tf
 4.  Configure the appropriate instance sizes desired in the variables.tf
 5.  Kick it off
```
 $ terraform init
 $ terraform plan
 $ terraform apply
```
 SSH into the outputed DNS entry
```
 $ ssh -i <path to ec2 key> ec2-user@<dns URL for bastion server>
```
 cd to /standard_replication
```
$ cd /standard replication on the bastion instance
```
 Trigger ansible script to build environment
 ```
 $ ansible-playbook -i inventory provision.yml
 ```
 The EC2 key is copied to the bastion and placed in the /tmp directory.  You can ssh to any of the instances from the bastion server:
 ```
 $ ssh -i /tmp/<keyname>.pem ec2-user@<choose a server from below>
 ``` 
 10.0.2.10 - MariaDB1
 10.0.3.10 - MariaDB2
 10.0.4.10 - MariaDB3
 
 10.0.2.20 - Maxscale 1
 10.0.3.20 - Maxscale 2 (or load testing instance)
 
 
 
 To tear down any artifacts built 
```
 $ terraform destroy
```
