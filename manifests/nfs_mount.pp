# == Define monit::nfs_mount
# Put under monitored service nfs mount.
# This define put, if the nfs share is mounted, a monit.token file under $mountpoint and configure monit to monitor this file.
#
# === Parameters
#
# [*mountpoint*]
#   mountpoint of the share nfs
#
# [*action*]
#   action to perform if nfs share is not mounted (monit.token file doesn't exists)
#
define monit::nfs_mount (
  $mountpoint,
  $action,
) {

  include monit

  if !defined(Concat_build['nfs_mount']) {
    concat_build { 'nfs_mount':
      order  => ['*.tmp'],
      target => "${monit::params::check_dir}/nfs_mount",
      notify => Service['monit']
    }
  }

  if !defined(Concat_fragment['nfs_mount+001.tmp']) {
    concat_fragment {'nfs_mount+001.tmp':
      content => '#GENERATED BY PUPPET through modules/monit/manifests/nfs_mount'
    }
  }

  $stripped_name=regsubst(regsubst($name,'/','-','G'),'\ ','-','G')
  concat_fragment { "nfs_mount+002-${stripped_name}.tmp":
    content => template('monit/check/nfs_mount.erb')
  }

  #crea il file del monitoraggio se la share nfs è montata
  exec {"create_token_${name}":
    command => "/usr/bin/touch ${mountpoint}/monit.token",
    creates => "${mountpoint}/monit.token",
    onlyif  => "mount -t nfs | grep '${mountpoint}'",
  }

}
