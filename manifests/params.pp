class ipsec::params {

  case $::osfamily {
    'freebsd': {
      $ipsec_setkey_conf   = '/etc/ipsec.conf'
      $ipsec_racoon_conf   = '/usr/local/etc/racoon/racoon.conf'
      $ipsec_psk_file      = '/usr/local/etc/racoon/psk.txt'
      $ipsec_setkey_cmd    = '/sbin/setkey'
      # $package_name      = [ 'security/racoon2' ] # racoon2 is sketch
      $ipsec_packages      = [ 'security/ipsec-tools' ]
      $ipsec_racoon_dir    = '/usr/local/etc/racoon'
      $ipsec_racoon_daemon = 'racoon'
    }
    'openbsd': {}
    'debian': {
      $ipsec_setkey_conf = '/etc/setkey.conf'
      $ipsec_setkey_cmd  = '/sbin/setkey'
      $package_name      = [ 'ipsec-tools' ]
    }
    default: {
      fail("Sorry, IPSec is not supported on ${::osfamily}")
    }
  }
}
