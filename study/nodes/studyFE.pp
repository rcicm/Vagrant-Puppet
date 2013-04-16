#Update server
exec { "apt-get update":
  path => "/usr/bin",
}

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

#Installing/Configuring Apache 
include study::apache
#Adding a moutpoint
util::mount { "/mnt/meumout":
  device  => "10.2.48.40:/tmp",
  options => "defaults,bg,intr",
  ensure  => "mounted",
}

#Adding the adminitration user
util::adduser { "suporte":
  shell => '/bin/bash', 
  username => 'suporte',
}
