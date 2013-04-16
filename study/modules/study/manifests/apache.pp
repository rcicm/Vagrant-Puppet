class study::apache {
  package { "apache2":
    ensure  => present,
    require => Exec["apt-get update"],
  }
  service { "apache2":
    ensure  => "running",
    require => Package["apache2"],
  }
  file { "/var/www/study":
    ensure  => "link",
    target  => "/vagrant/extras/htdocs-study",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
  file { "/etc/hosts":
    ensure  => "link",
    target  => "/vagrant/extras/hosts",
  }

  file { "/etc/apache2/mods-enabled/proxy.load":
    ensure  => "link",
    target  => "/etc/apache2/mods-available/proxy.load",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
  
  file { "/etc/apache2/mods-enabled/proxy_http.load":
    ensure  => "link",
    target  => "/etc/apache2/mods-available/proxy_http.load",
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
  
  file { '/etc/apache2/mods-enabled/proxy.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template( 'study/proxy.conf.erb' ),
    require => Package["apache2"],
    notify  => Service["apache2"],
  }
}
