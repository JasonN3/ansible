class webserver () {
  package { 'httpd':
    ensure => installed,
  }

  service { 'httpd':
    enable  => false,
    require => Package['httpd'],
  }
}
