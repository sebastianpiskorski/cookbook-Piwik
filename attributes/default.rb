require 'securerandom'

# PHP
default['php']['version'] = '5.6.19'
default['php']['install_method'] = 'package'
default['php']['directives'] = {
	"date.timezone" => 'Europe/Warsaw',
	"always_populate_raw_post_data" => -1
}
default['php']['package_options'] = '--force-yes'

# PHP-FPM
default['php-fpm']['user'] = 'vagrant'
default['php-fpm']['group'] = 'vagrant'

# Nginx
default['nginx']['user'] = 'vagrant'
default['nginx']['group'] = 'vagrant'

# MariaDB
default['mariadb']['server_root_password'] = 'vagrant'

# PhantomJS
default['phantomjs']['version'] = '2.1.1'
default['phantomjs']['base_url'] = 'https://bitbucket.org/ariya/phantomjs/downloads'
default['phantomjs']['basename'] = "phantomjs-#{node['phantomjs']['version']}-linux-#{node['kernel']['machine']}"

# Piwik
default['piwik']['db'] = 'mariadb'
default['piwik']['host_address'] = '127.0.0.1'
default['piwik']['host_name'] = 'piwik.local'
default['piwik']['install_piwik'] = true
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
		'password' => default['mariadb']['server_root_password'],
		'name' => 'piwik',
		'tables_prefix' => 'piwik_'
	},
	'general' => {
		'salt' => SecureRandom.hex,
		'session_handler' => 'dbtable',
		'piwik_domain' => 'piwik.local'
	},
	'database_tests' => {
		'host' => '127.0.0.1',
		'username' => 'root',
		'password' => 'vagrant',
		'db_name' => 'piwik_tests',
		'tables_prefix' => 'piwik_'
	},
	'tests' => {
		'http_host' => default['piwik']['host_name'],
		'request_uri' => '/'
	}
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

default['piwik']['gems'] = %w(
	mysql2
)

default['piwik']['php_packages'] = %w(
	libmysqlclient-dev
	php5-curl
	php5-mysql
	php5-gd
	php5-ldap
)
