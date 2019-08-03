class nginx{

package{"nginx":
  ensure => latest,
  before => File["/var/www/ve-server1.com/public"]
}
file{"/var/www":
 ensure => directory,
 require => Package["nginx"]
}
file{"/var/www/ve-server1.com":
 ensure => directory,
 require => Package["nginx"]
}
file{"/var/www/ve-server2.com":
 ensure => directory,
 require => Package["nginx"]
}
file{"/var/www/ve-server1.com/public":
 ensure => directory,
 require => [ Package["nginx"],File["/var/www/ve-server1.com"]]
}
file{"/var/www/ve-server2.com/public":
 ensure => directory,
 require => [ Package["nginx"],File["/var/www/ve-server2.com"]]
}

file{"/var/www/ve-server1.com/logs":
 ensure => directory,
 require => Package["nginx"]
}
file{"/var/www/ve-server2.com/logs":
 ensure => directory,
 require => Package["nginx"]
}
file{"/etc/nginx/sites-available":
 ensure => directory,
 require => Package["nginx"]
}
file {"/var/www/ve-server1.com/public/index.html":
 ensure => file,
 source => "puppet:///modules/nginx/index1.html",
 require => Package["nginx"]
}
file {"/var/www/ve-server2.com/public/index.html":
 ensure => file,
 source => "puppet:///modules/nginx/index2.html",
 require => Package["nginx"]
}
file {"/etc/nginx/sites-available/ve-server1.com":
 ensure => file,
 source => "puppet:///modules/nginx/ve-server1.conf",
 require => Package["nginx"],
 notify => Service["nginx"]
}
file {"/etc/nginx/sites-available/ve-server2.com":
 ensure => file,
 source => "puppet:///modules/nginx/ve-server2.conf",
 require => Package["nginx"]
}
file{"/etc/nginx/sites-enabled/ve-server1.com":
 ensure => link,
 target => "/etc/nginx/sites-available/ve-server1.com",
 require => [Package["nginx"],File["/etc/nginx/sites-available"]]
}
file{"/etc/nginx/sites-enabled/ve-server2.com":
 ensure => link,
 target => "/etc/nginx/sites-available/ve-server2.com",
 require => [Package["nginx"],File["/etc/nginx/sites-available"]]
}
service {"nginx":
 ensure => running,
 subscribe => [ Package["nginx"],File['/etc/nginx/sites-enabled/ve-server2.com'],File["/etc/nginx/sites-enabled/ve-server1.com"]]
}

}

