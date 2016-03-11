define monit::smtp(
  $smtp = ''
) {

  include monit

  $smtp_address = $smtp ? {
    ''      => $name,
    default => $smtp
  }

  file { "${monit::params::check_dir}/smtp":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "set mailserver ${smtp_address}",
    notify  => Service['monit']
  }

}
