# Class: ipsec:sasyncd
#
# Manage the sasycnd.conf(5) and control the sasyncd(8) daeomon.
#
# This is useful for building redundant IPSec gateways.
#
# * peer: a list of peers with which to sync states.
# * interface: the interface to watch for carp state.
# * sharedkey prefix the output of `openssl rand -hex 32` with 0x.
#
class ipsec::sasyncd (
  $peer      = [],
  $interface = undef,
  $sharedkey = undef,
) {

  include ipsec::setup

  case $::osfamily {
    'openbsd': {
      file { '/etc/sasyncd.conf':
        owner   => 'root',
        group   => '0',
        mode    => '0600',
        content => template('ipsec/openbsd/sasyncd.conf.erb'),
        notify  => Service['sasyncd'],
      }

      service { 'sasyncd':
        ensure    => running,
        enable    => true,
        subscribe => Service['isakmpd'],
      }
    }
    default: {}
  }
}
