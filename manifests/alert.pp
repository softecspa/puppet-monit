define monit::alert(
  $address = ''
) {

  include monit

  $mail_address = $address ? {
    ''      => $name,
    default => $address
  }

  $filename=regsubst($mail_address,'@','-at-')

  file { "${monit::params::check_dir}/${filename}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "set alert ${mail_address}",
    notify  => Service['monit']
  }

}
