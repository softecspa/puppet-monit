# == Class: monit
# This module manage monit service.
#
# === Parameters
#
# [*check_interval*]
#   interval in seconds between checks. Default: 120
#
# [*start_delay*]
#   delay the first check. Default: 30
#
# [*logfile*]
#   path for the logfile. If false monit will log in syslog. Default: /var/log/monit.log
#
# [*httpd*]
#   if set to tru enable httpd service. Default: true
#
# [*httpdport*]
#   if httpdport is set to true, this parameter specify httpd service listen port
#
# [*allow*]
#   host and/or users and/or groups allowed to contact webserver. It can be a string or an array. Accepted for are:
#   * "localhost"       (allow from localhost)
#   * "admin:monit"     (require user 'admin' with password 'monit')
#   * "@monit"          (allow users of group 'monit' to connect (rw))
#   * "@users readonly" (allow users of group 'users' to connect readonly)
#
class monit (
  $check_interval = '120',
  $start_delay    = '30',
  $logfile        = '/var/log/monit.log',
  $httpd          = true,
  $httpdport      = '2812',
  $allow          = [ 'localhost' ],
){

  validate_bool($httpd)

  if $httpd {
    if !is_integer($httpdport) {
      fail('if httpd is true, httpdport must be an integer value')
    }

    if $allow == '' {
      fail ('if httpd is true, you must specify allow parameter as string or array')
    }

    if is_array($allow) {
      $allowed = $allow
    }
    else {
      $allowed = [ $allow ]
    }
  }


  include monit::params
  include monit::install
  include monit::config
  include monit::service

  Class['monit::install'] ->
  Class['monit::config'] ->
  Class['monit::service']

}
