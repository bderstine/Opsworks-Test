#
# Cookbook Name:: bizzar_nodejs
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node.default['nodejs']['install_method'] = 'binary'
node.default['nodejs']['version'] = '6.6.0'
node.default['nodejs']['binary']['checksum'] = 'c22ab0dfa9d0b8d9de02ef7c0d860298a5d1bf6cae7413fb18b99e8a3d25648a' 

include_recipe "nodejs"

execute "Add node/npm path to /etc/profile" do
  command "echo 'export PATH=$PATH:/usr/local/bin:/usr/local/nodejs-binary/bin' >> /etc/profile"
  not_if 'grep usr/local/bin /etc/profile'
end

# These will install -global
nodejs_npm "nodemon"
nodejs_npm "pm2"

user 'deploy' do
	manage_home true
	shell '/bin/bash'
end