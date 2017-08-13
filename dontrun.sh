sudo knife ec2 server create -f t2.micro -I ami-d14062aa --security-group-ids [security group allowing connection] --ssh-user ubuntu
knife bootstrap -i *****.pem [instance public dns] -N awsec2 -x ubuntu --sudo
knife node run_list set awsec2 'recipe[main1::default]'
ssh -i *****.pem ubuntu@[instance public dns]
sudo chef-client
