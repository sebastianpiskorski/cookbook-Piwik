#
# Cookbook Name:: piwik
# Resource:: plugin
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
resource_name :piwik_git_plugin

property :version, String, default: 'master'
property :url, String
property :name, String

action :install do
	pluginDir = "#{node['piwik']['dir']}/plugins/#{name}"

	if ::File.exist?(pluginDir)
		log "Plugin #{name} already exists." do
			level :info
		end
		return
	end

	directory pluginDir do
		user node['piwik']['user']
		group node['piwik']['group']
		action :create
	end

	git pluginDir do
		repository url
		revision version
		action :checkout
	end
end

action :uninstall do
	pluginDir = "#{node['piwik']['dir']}/plugins/#{name}"

	if !::File.exist?(pluginDir)
		log "Plugin #{name} doesn't exist." do
			level :info
		end
		return
	end

	directory pluginDir	do
		action :delete
	end	
end

action :activate do
	pluginName = name

	piwik_command 'activate plugin' do
		command 'plugin:activate'
		args [pluginName]
	end
end

action :deactivate do
	pluginName = name

	piwik_command 'deactivate plugin' do
		command 'plugin:deactivate'
		args [pluginName]
	end
end