#
# Cookbook Name:: piwik
# Recipe:: testing
#
# Copyright (C) 2016 Kamil Zajac
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'phantomjs'

if node['platform'] == 'debian'
	apt_repository 'ttf-mscorefonts-installer' do
		uri 'http://ftp.de.debian.org/debian'
		distribution 'jessie'
		components ['main', 'contrib']
	end
end

package 'ttf-mscorefonts-installer'
package 'imagemagick'
package 'imagemagick-doc'

mysql_database node['piwik']['config']['database_tests']['db_name'] do
  connection(
    :host     => node['piwik']['config']['database_tests']['host'],
    :username => node['piwik']['config']['database_tests']['user'],
    :password => node['piwik']['config']['database_tests']['password']
  )
  action :create
end

gem_package 'travis'