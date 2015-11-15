
class my_module {

	# HOSTS

	host { 'mysql1':
		ensure => 'present',
		target => '/etc/hosts',
		ip => '127.0.0.1',
		host_aliases => ['mysql']
	}

	host { 'memcached1':
		ensure => 'present',
		target => '/etc/hosts',
		ip => '127.0.0.1',
		host_aliases => ['memcached']
	}

	# APACHE

	class { 'apache':  }

	apache::vhost { 'centos.dev':
	  port    => '80',
	  docroot => '/var/www',
	}

	apache::vhost { 'project1.dev':
	  port    => '80',
	  docroot => '/var/www/project1',
	}

	# MYSQL

	class { '::mysql::server':
	  root_password           => 'vagrantpass',
	  remove_default_accounts => true
	}

	mysql::db { 'mpwar_test':
	  user     => 'user',
	  password => 'mpwardb',
	  host     => 'localhost',
	  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
	}

	# PHP

	$php_version = '56'

	include ::yum::repo::remi


	if $php_version == '55' {
		include ::yum::repo::remi_php55
	}
	elsif $php_version == '56'{
		::yum::managed_yumrepo { 'remi-php56':
		  descr          => 'Les RPM de remi pour Enterpise Linux $releasever - $basearch - PHP 5.6',
		  mirrorlist     => 'http://rpms.famillecollet.com/enterprise/$releasever/php56/mirror',
		  enabled        => 1,
		  gpgcheck       => 1,
		  gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi',
		  gpgkey_source  => 'puppet:///modules/yum/rpm-gpg/RPM-GPG-KEY-remi',
		  priority       => 1,
		}
	}

	class { 'php': 
		version => 'latest',
		require => Yumrepo['remi-php56']
	}

	# EPEL repo

	include ::yum::repo::epel

	# MEMCACHED

	#class { 'memcached': }

	# Files

	file { '/var/www/index.php':
	    ensure  => 'present',
	    content => "<h1>HEY I'm in the base folder !</h1>",
	    mode    => '0644',
  	}

  file { '/var/www/project1/index.php':
    ensure  => 'present',
    content => "<h1>HEY I'm in the project1 folder !</h1>",
    mode    => '0644',
  }

}
