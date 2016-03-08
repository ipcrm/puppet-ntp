#simple ntp class
class ntp {
  package { 'ntp':
    ensure => present,
  }
  service { 'ntp':
    ensure  => running,
    enable  => true,
    require => Package['ntp'],
  }
  file { '/etc/ntp.conf':
    ensure => present,
    source => 'puppet:///modules/ntp/ntp.conf',
    notify => Service['ntp'],
  }
}
