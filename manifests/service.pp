class monit::service {
  service {'monit':
    ensure      => $monit::service_ensure,
    enable      => $monit::service_enable,
    hasrestart  => true,
    hasstatus   => false,
    status      => 'pidof monit'
  }
}
