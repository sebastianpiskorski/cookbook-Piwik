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

	#apt_repository 'team-mayhem-php5' do
	#	uri 'http://ppa.launchpad.net/team-mayhem/ppa/ubuntu'
	#	distribution 'precise'
	#	components ['main']
	#	deb_src true
	#	key 'F442D7D7'
	#	keyserver 'keyserver.ubuntu.com'
	#end
end

include_recipe "piwik::db-#{node['piwik']['db']}"
include_recipe 'nginx'
include_recipe 'php'
include_recipe 'php-fpm'
include_recipe 'git'
include_recipe 'composer'

hostsfile_entry node['piwik']['host_address'] do
	hostname node['piwik']['host_name']
	unique true
end

template "#{node['nginx']['dir']}/sites-enabled/piwik" do
	source 'nginx-site.conf.erb'
	variables({
		:directory => node['piwik']['dir'],
		:name => node['piwik']['host_name'],
		:address => "#{node['piwik']['host_address']}:80"
	})
end

node['piwik']['packages'].each do |piwikPackage|
	package piwikPackage do
		options '--force-yes'
		action :install
	end
end

node['piwik']['gems'].each do |piwikGem|
	gem_package piwikGem
	chef_gem piwikGem do
		compile_time false
		action :install
	end
end

service 'php5-fpm' do
	action :restart
end

service 'nginx' do
	action :restart
end
