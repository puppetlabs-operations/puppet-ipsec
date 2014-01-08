class ipsec::setup::openbsd (
  $enable = true
) {

  if $enable == true {
    $value = 1
  } else {
    $value = 0
  }

  Sysctl::Value { value => $value }

  sysctl::value { 'net.inet.ah.enable': }
  sysctl::value { 'net.inet.esp.enable': }
  sysctl::value { 'net.inet.ipcomp.enable': }

  # We should really add suppoort for IKE as well
  service { 'isakmpd':
    ensure => running,
    enable => true,
  }
}
