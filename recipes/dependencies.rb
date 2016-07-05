#
# Cookbook Name:: piwik
# Recipe:: dependencies
#
# Copyright (C) 2016 Kamil Zajac <kaz231@outlook.com>
#
# All rights reserved - Do Not Redistribute
#
if node['platform'] == 'ubuntu'
	apt_repository 'ondrej-php56' do
		uri 'http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu'
		distribution 'precise'
		components ['main']
		deb_src true
	end
end

include_recipe "piwik::db-#{node['piwik']['db']}"
include_recipe 'php'
include_recipe 'php-fpm'
include_recipe 'git'
include_recipe 'composer'

node['php_packages'].each do |php_package|
	package php_package do
		action :install
	end
end

service 'php5-fpm' do
	action :restart
end

service 'nginx' do
	action :restart
end
