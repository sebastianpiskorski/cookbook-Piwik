#
# Cookbook Name:: piwik
# Recipe:: config
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
if !::File.exist?("#{node['piwik']['dir']}/config/config.ini.php")
	template "#{node['piwik']['dir']}/config/config.ini.php" do
		source 'config.ini.php.erb'
		user node['piwik']['user']
		group node['piwik']['group']
		variables({
			:db_host => node['piwik']['config']['database']['host'],
			:db_user => node['piwik']['config']['database']['user'],
			:db_password => node['piwik']['config']['database']['password'],
			:db_name => node['piwik']['config']['database']['name'],
			:db_tables_prefix => node['piwik']['config']['database']['tables_prefix'],
			:general_salt => node['piwik']['config']['general']['salt'],
			:general_piwik_domain => node['piwik']['config']['general']['piwik_domain'],
			:general_session_handler => node['piwik']['config']['general']['session_handler']
		})
	end
end