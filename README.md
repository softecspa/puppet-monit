puppet-monit
============

install and configure monit. It adds some defines to manage resources through monit.

##Overview
Module can be used directly using its defiens. Each define include monit module

##Define monit::smtp
Configure smtp to use:

    monit::smtp {'smtp_address':}

##Define monit::alert
configure mailaddress to send alert

    monit::alert {'email@address.it':}

##Define monit::nfs
Configure monitoring through monit of a nfs mountpoint. It defines an action to execute in case of failure

    monit::nfs_mount { $name :
      mountpoint  => $mountpoint,
      action      => '/usr/local/sbin/puppet-run -f1 -c',
    }
