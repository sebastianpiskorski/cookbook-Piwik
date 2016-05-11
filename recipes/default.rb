#
# Cookbook Name:: piwik
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'git'
include_recipe 'composer'

if Dir["#{node['piwik']['dir']}/*"].empty?
	git node['piwik']['dir'] do
		repository node['piwik']['repository_url']
		enable_submodules node['piwik']['enable_submodules']
		revision node['piwik']['version']
		depth 1
		timeout 1800
		user node['piwik']['user']
		group node['piwik']['group']
		action :checkout
	end
end

composer_project node['piwik']['dir'] do
	dev true
	quiet false
	prefer_dist false
	action :install
end