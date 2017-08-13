current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "*****"
client_key               "~/chef-repo/*****.pem"
chef_server_url          "https://api.chef.io/organizations/tstchk"
cookbook_path            ["~/chef-repo/cookbooks"]
knife[:ssh_key_name] = "*******"
knife[:aws_access_key_id] = "********************"
knife[:aws_secret_access_key] = "********************************"
knife[:region] = "us-east-2"
