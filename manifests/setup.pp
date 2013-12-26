# Class: ipsec::setup
#
# Setup any prereqs for IPSec
#
class ipsec::setup (
  $package_name = $ipsec::params::package_name,
) inherits ipsec::params {

  case $::osfamily {
    'openbsd': {
      include ipsec::setup::openbsd
    }
    'freebsd': {
      include ipsec::setup::freebsd
    }
    default: {
      warn("${::osfamily} is not supported by ipsec::setup")
    }
  }

  if $package_name {
    package{ $ipsec::params::package_name:
      ensure => present,
      alias  => 'ipsec',
    }
  }
}
