class monit::config {

  file {'/etc/monit/monitrc':
    ensure  => present,
    content => template("monit/etc/monitrc_${::lsbdistcodename}.erb"),
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    notify  => Service['monit'],
  }

  augeas { 'monit_default':
    context => '/files/etc/default/monit',
    changes => [
      'set startup 1',
    ],
    notify  => Service['monit'],
  }

  if !defined(File[$monit::params::check_dir]) {
    file { $monit::params::check_dir :
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0755'
    }
  }

  if !defined(File["${monit::params::check_dir}/dummy"]) {
    file { "${monit::params::check_dir}/dummy":
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      require => File[$monit::params::check_dir],
      notify  => Service['monit']
    }
  }
}
