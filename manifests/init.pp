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
}
