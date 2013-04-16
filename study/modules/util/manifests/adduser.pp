define util::adduser ($username, $shell) {
  user { $username:
    ensure => present,
    home => "/home/$username",
    shell => "$shell",
  }
}
