#
# Cookbook Name:: piwik-plugin-dev
# Recipe:: database
#
# Copyright (C) 2016 Kamil Zajac <kaz231@outlook.com>
#
# All rights reserved - Do Not Redistribute
#
mysql_database node['piwik']['config']['database']['name'] do
 	connection(
    	:host     => node['piwik']['config']['database']['host'],
    	:username => node['piwik']['config']['database']['user'],
    	:password => node['piwik']['config']['database']['password']
  	)
  	action :create
end