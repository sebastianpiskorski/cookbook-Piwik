#
# Cookbook Name:: piwik
# Recipe:: db-mariadb
#
# Copyright (C) 2016 Kamil Zajac
#
# All rights reserved - Do Not Redistribute
#
if node['platform'] == 'ubuntu'
	apt_repository 'mariadb' do
		uri 'http://mariadb.kisiek.net/repo/10.0/ubuntu'
		distribution 'precise'
		components ['main']
		keyserver 'keyserver.ubuntu.com'
		key '0xcbcb082a1bb943db'
		deb_src true
		arch 'amd64'
	end

	apt_repository 'mariadb-nucleus' do
		uri 'http://mariadb.mirror.nucleus.be/repo/10.0/ubuntu'
		distribution 'precise'
		components ['main']
		keyserver 'keyserver.ubuntu.com'
		key '0xcbcb082a1bb943db'
		deb_src true
		arch 'amd64'
	end
end

include_recipe 'mariadb'

if node['platform'] == 'ubuntu'
	package 'libmysqlclient18' do
		action :install
		options '--force-yes'
		#version '10.0.27+maria-1~precise'
	end

	package 'mysql-common' do
  	action :install
		options '--force-yes'
		#version '10.0.27+maria-1~precise'
	end

	package 'libmariadbd-dev' do
  	action :install
	end
else
	package 'libmysqlclient-dev' do
                action :install
                options '--force-yes'
	end
end
