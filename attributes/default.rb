require 'securerandom'

default['piwik']['version'] = '2.16.0'
default['piwik']['dir'] = '/piwik'
default['piwik']['repository_url'] = 'https://github.com/piwik/piwik.git'
default['piwik']['user'] = 'vagrant'
default['piwik']['group'] = 'vagrant'
default['piwik']['enable_submodules'] = false

default['piwik']['config'] = {
	'database' => {
		'host' => '127.0.0.1',
		'user' => 'root',
		'password' => '',
		'name' => 'piwik',
		'tables_prefix' => 'piwik_'
	},
	'general' => {
		'salt' => SecureRandom.hex,
		'session_handler' => 'dbtable',
		'piwik_domain' => 'piwik.local'
	},
	'database_tests' => nil,
	'tests' => nil
}

default['piwik']['admin'] = {
	'username' => 'admin',
	'password' => 'admin12345',
	'email' => 'admin@admin.com'
}

default['piwik']['website'] = {
	'name' => 'TestWebsite',
	'url' => 'test.com'
}

default['piwik']['git']['user'] = 'vagrant'