
class nginx($version=1.0.0){

$package = nginx
notify{" $fqdn  $osfamily "}
package{$package:
  ensure => latest,
  before => File["/tmp/server.xml"]
}
file{"/tmp/server.xml"
  ensure => file,
  content => "hvhhvhj",
  require => Package["nginx"],
  notify => Service["nginx"]
}
service{$package:
  ensure => running
  subscribe => [ File["/tmp/server.xml"], Package["nginx"] ]
}
}
