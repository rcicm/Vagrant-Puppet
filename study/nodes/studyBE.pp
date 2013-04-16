#Update server
exec { "apt-get update":
  path => "/usr/bin",
}

Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

#Installing/Configuring Apache 
include study::tomcat6
#Adding a moutpoint
util::mount { "/mnt/studyBE":
  device  => "10.0.2.2:/tmp",
  options => "defaults,bg,intr",
  ensure  => "unmounted",
}

#Adding the adminitration user
util::adduser { "suporte":
  shell => '/bin/bash', 
  username => 'suporte',
}
