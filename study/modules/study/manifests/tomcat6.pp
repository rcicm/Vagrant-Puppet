class study::tomcat6 {
  package { "tomcat6":
    ensure  => present,
    require => Exec["apt-get update"],
  }
  service { "tomcat6":
    ensure  => "running",
    require => Package["tomcat6"],
  }
}
