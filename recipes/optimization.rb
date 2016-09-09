#
# Cookbook Name:: piwik
# Recipe:: optimization
#
# Copyright (C) 2016 Kamil Zajac
#
# All rights reserved - Do Not Redistribute
#
config = node['piwik']

if config['nfs_optimization']
  homeDir = ::Dir.home(config['user'])
  tmpDir = "#{config['dir']}/tmp"
  homeTmpDir = "#{homeDir}/piwik_tmp"

  if !::File.symlink?(tmpDir)

    if ::Dir.exist?(tmpDir)
      execute "Moves #{tmpDir} to #{homeTmpDir}" do
        command "mv #{tmpDir} #{homeTmpDir}"
        user config['user']
        group config['group']
        environment({
           'HOME' => ::Dir.home(config['user']),
           'USER' => config['user']
        })
        action :run
      end
    else
      directory homeTmpDir do
        owner config['user']
        group config['group']
        action :create
      end
    end

    link tmpDir do
      to homeTmpDir
    end
  end
end
