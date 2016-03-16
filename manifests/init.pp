#simple ntp class
class ntp (
  String $package_name = $::ntp::params::package_name,
  String $service_name = $::ntp::params::service_name,
  String $config_file  = $::ntp::params::config_file,
  Array $servers       = $::ntp::params::servers,
) inherits ::ntp::params {

  package { $package_name:
    ensure => present,
  }

  service { $service_name:
    ensure    => running,
    enable    => true,
    require   => Package['ntp'],
    subscribe => File[$config_file],
  }

  file { $config_file:
    ensure  => present,
    content => template('ntp/ntp.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

}
