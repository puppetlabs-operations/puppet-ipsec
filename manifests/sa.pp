# Define: ipsec::sa
#
# Manage an IPSec Security Association between security gateways.
#
define ipsec::sa (
  $local_router,
  $local_network,
  $remote_router,
  $remote_network,
  $key,
) {

  include ipsec::setup

  case $::osfamily {
    'openbsd': {
      file { '/tmp/ipsec.conf':
        owner   => 'root',
        group   => '0',
        mode    => '0600',
        content => template('ipsec/openbsd/ipsec.conf.erb'),
        notify  => Exec['ipsecctl_reload'],
      }

      exec { 'ipsecctl_reload':
        command     => '/sbin/ipsecctl -nf /tmp/ipsec.conf && cat /tmp/ipsec.conf > /etc/ipsec.conf && /sbin/ipsecctl -f /etc/ipsec.conf',
        refreshonly => true,
      }

      file { '/etc/ipsec.conf':
        owner => 'root',
        group => '0',
        mode  => '0600',
      }
    }
    default: {}
  }
}
