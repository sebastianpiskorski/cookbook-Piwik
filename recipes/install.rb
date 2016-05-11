#
# Cookbook Name:: piwik
# Recipe:: install
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'piwik::config'

piwik_git_plugin 'Fetch and activate ConsoleInstaller plugin' do
	url 'https://github.com/kaz231/plugin-ConsoleInstaller.git'
	name 'ConsoleInstaller'
	action [:install, :activate]
end

piwik_command 'install database' do
	command 'console-installer:create-db-tables'
	action :execute
end

piwik_command 'update core' do
	command 'core:update'
	params({ 'yes' => nil })
	action :execute
end

piwik_command 'create super user' do
	command 'console-installer:create-super-user'
	args [node['piwik']['admin']['username'], node['piwik']['admin']['password'], node['piwik']['admin']['email']]
	params({ 'quiet' => nil, 'exception-to-log' => nil })
	action :execute
end

piwik_command 'create website' do
	command 'console-installer:create-website'
	args [node['piwik']['website']['name'], node['piwik']['website']['url']]
	params({ 'quiet' => nil, 'exception-to-log' => nil })
	action :execute
end