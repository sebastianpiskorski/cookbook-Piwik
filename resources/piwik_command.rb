#
# Cookbook Name:: piwik
# Resource:: piwik_command
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
resource_name :piwik_command

property :command, String
property :args, kind_of: Array, default: []
property :params, kind_of: Hash, default: {}
property :outputDestination, String, default: nil

action :execute do
	paramsStr = ''
	argumentsStr = args.join(' ')
	parametersArray = []

	if !params.nil?
		params.each_pair do |key, value|
			if value.nil?
				paramToAdd = "--#{key}"
			else
				paramToAdd = "--#{key}='#{value}'"
			end

			parametersArray = parametersArray + [paramToAdd]
		end

		paramsStr = parametersArray.join(' ')
	end

	piwikCommand = "php ./console #{new_resource.command} #{argumentsStr} #{paramsStr}"

	if !outputDestination.nil?
		piwikCommand = "#{piwikCommand} > #{outputDestination}"
	end

	execute "Execution of #{command}" do
		cwd node['piwik']['dir']
		command piwikCommand
		returns [0, 1, 2, 255]
		action :run
	end
end