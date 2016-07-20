#
# Cookbook Name:: piwik
# Recipe:: testing
#
# Copyright (C) 2016 Kamil Zajac
#
# All rights reserved - Do Not Redistribute
#
phantomjsSourceDir = "#{node['piwik']['home_dir']}/phantomjs_versions"

directory phantomjsSourceDir do
	user node['piwik']['user']
	group node['piwik']['group']
	action :create
end

cookbook_file "#{phantomjsSourceDir}/#{node['phantomjs']['basename']}.tar.bz2" do
  source "#{node['phantomjs']['basename']}.tar.bz2"
  owner node['piwik']['user']
  group node['piwik']['group']
end

include_recipe 'phantomjs'

if node['platform'] == 'debian'
	apt_repository 'ttf-mscorefonts-installer' do
		uri 'http://ftp.de.debian.org/debian'
		distribution 'jessie'
		components ['main', 'contrib']
	end
end

#package 'ttf-mscorefonts-installer'
package 'gsfonts-x11'
package 'imagemagick'
package 'imagemagick-doc'

fonts = %w(
	Arial_Bold_Italic.ttf
	Arial_Bold.ttf
	Arial_Italic.ttf
	Arial.ttf
	Courier_New.ttf
	Verdana_Bold_Italic.ttf
	Verdana_Bold.ttf
	Verdana_Italic.ttf
	Verdana.ttf
)

fontsDir = "#{node['piwik']['home_dir']}/.fonts"

directory fontsDir do
  owner node['piwik']['user']
  group node['piwik']['group']
  action :create
end

fonts.each do |font|
	cookbook_file "#{fontsDir}/#{font}" do
	  source "fonts/#{font}"
	  owner node['piwik']['user']
	  group node['piwik']['group']
	end
end

execute 'reload fonts cache' do
	command "fc-cache -f -v"
	user node['piwik']['user']
	environment ({'HOME' => node['piwik']['home_dir'], 'USER' => node['piwik']['user']})
	cwd node['piwik']['home_dir']
	action :run
end

mysql_database node['piwik']['config']['database_tests']['db_name'] do
  connection(
    :host     => node['piwik']['config']['database_tests']['host'],
    :username => node['piwik']['config']['database_tests']['user'],
    :password => node['piwik']['config']['database_tests']['password']
  )
  action :create
end

gem_package 'travis'
