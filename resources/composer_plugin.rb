
# Cookbook Name:: piwik
# Resource:: composer_plugin
#
# Copyright (C) 2015 Kamil Zajac
#
# All rights reserved - Do Not Redistribute
#
resource_name :piwik_composer_plugin

property :plugin_name, String, name_property: true
property :plugin_version, String
property :repository, String
property :piwik_dir, String
property :composer_bin, String, default: 'composer'
property :user, String, default: 'root'
property :group, String, default: 'root'

def getEnvironment (_user)
  return {
     'HOME' => ::Dir.home(_user),
     'USER' => _user
  }
end

action :install do
  _user = user
  _group = group

  if !repository.nil?
    pluginSlug = plugin_name.gsub!(/\W/i, '_')

    execute "Installs plugin's repository #{pluginSlug} - #{repository}" do
      cwd piwik_dir
      command "#{composer_bin} config repositories.#{pluginSlug} vcs #{repository}"
      user _user
      group _group
      environment(getEnvironment(_user))
      action :run
    end
  end

  requiredPlugin = plugin_name

  if !plugin_version.nil?
    requiredPlugin = "#{plugin_name}:#{plugin_version}"
  end

  execute "Installs plugin #{plugin_name}" do
    cwd piwik_dir
    command "#{composer_bin} require #{requiredPlugin}"
    user _user
    group _group
    environment(getEnvironment(_user))
    action :run
  end

  execute "Moves plugin #{plugin_name} to plugins/ dir" do
    command "mv #{piwik_dir}/vendor/#{plugin_name} #{piwik_dir}/plugins/"
    user _user
    group _group
    environment(getEnvironment(_user))
    action :run
  end
end
