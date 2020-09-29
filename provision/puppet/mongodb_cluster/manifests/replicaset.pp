node /(node2|node3)/ {
  include replset::mongodb
}

node /(node1)/{
  include replset::mongodb

  mongodb_replset { rsmain: 
    ensure => present,
    members => ['192.168.50.101:27017','192.168.50.102:27017','192.168.50.103:27017'],
  }

}

class replset::mongodb {
  class { '::mongodb::globals':
    manage_package_repo => true,
    version             => '4.0.4',
    bind_ip             => ['0.0.0.0'],
    service_ensure      => running,
    service_enable      => true,
  }
  -> class { '::mongodb::server':
    verbose         => true,
    restart         => true,
    port            => 27017,
    replset         => "rsmain",
  }
  -> class { '::mongodb::client': } # required, or mongodb_replset will fail with "Request failed: 'Command mongo is missing'"
}

node 'default' {
  notify {"the hostname $hostname did not match any of the listed definitions!": }
}
