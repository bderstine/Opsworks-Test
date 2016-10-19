#
# Cookbook Name:: bizzar_deploy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "git"

# Set the branch depending on the environment
if node.chef_environment == 'Prod'
   branch_name = 'master'
else
   #branch_name = 'develop'
   branch_name = 'master'
end

# Create directory for git clone target
directory '/srv/Node-Restify-Base' do
  owner 'deploy'
  group 'deploy'
  mode '0755'
  action :create
end

# Git clone github repo to directory
git '/srv/Node-Restify-Base' do
	repository 'https://github.com/bderstine/Node-Restify-Base'
	revision branch_name
	action :sync
	user 'deploy'
	group 'deploy'
end

# Run npm install
execute "run npm install" do
	cwd '/srv/Node-Restify-Base'
	command 'npm install'
	environment "HOME" => "/home/deploy"
	user 'deploy'
	group 'deploy'
end
