# AWS EC2 Instance launch using Chef and AWS APIS

Below script laucnhes and bootstraps an Amazon EC2 instance using Chef Server:


This will launch new EC2 instance, `t2.micro`, with AMI ID `ami-d14062aa` (Ubuntu 16.04), add it to a security group allowing ssh connection (open on port 22) will create user `ubuntu` on that instance, and proceed to bootstrap it:
```
knife ec2 server create -f t2.micro -I ami-d14062aa --security-group-ids [security group allowing connection] --ssh-user ubuntu
```

However, if operation does not proceed to bootstrapping, we can do it manually;
`-i` specifies ssh key for your account, using instance public DNS as FQDN, `-x` specifies username to log in and `-N` specifies a name to save this node under on Chef Server:
```
knife bootstrap -i *****.pem [instance public dns] -N awsec2 -x ubuntu --sudo
```

Now, let's add our cookbook and recipe to the node run list:
```
knife node run_list set awsec2 'recipe[main1::default]'
```

Next, as we have just a single node, we can log in to the instance with ssh and launch `chef-client`:
```
ssh -i *****.pem ubuntu@[instance public dns]
sudo chef-client
```

However, if we have more than one node, the best way will be to use `knife ssh` function, for example:

```
knife ssh 'name:*' 'sudo chef-client'
```



As for our knife.rb contents, main points are:

This line specifies our chef server key:
```
client_key               "~/chef-repo/*****.pem"
```

This is the key for AWS instance ssh connection:
```
knife[:ssh_key_name] = "*******"
```

AWS API Access Key and Secret Key:
```
knife[:aws_access_key_id] = "********************"
knife[:aws_secret_access_key] = "********************************"
```

This line (as pretty much any of the above) can be specified in the CLI request directly, but it is easier to use like this. Specify instance region: 
```
knife[:region] = "us-east-2"
```
