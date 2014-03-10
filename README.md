# IPSec Management with Puppet

This module aims to manage IPSec on BSD and Linux.

#### *ipsec::sa*

To establish an IPSec Security Association, or SA, use the `ipsec::sa` defined type.

On the *siteA* gateway, add the following.

``` Puppet
ipsec::sa { 'siteA_to_siteB':
  local_router   => $siteA_router,
  local_network  => $siteA_network,
  remote_router  => $siteB_router,
  remote_network => $siteB_network,
  key            => $key,
}
```

On the *siteB* gateway, add the reverse.

``` Puppet
ipsec::sa { 'siteB_to_siteA':
  local_router   => $siteB_router,
  local_network  => $siteB_network,
  remote_router  => $siteA_router,
  remote_network => $siteA_network,
  key            => $key,
}
```

#### *ipsec::sasyncd*

For redundant IPSec gateways, you will want to synchronize the SAs between the
gateway peers.  To do this, use the `ipsec::sasyncd` to control the `sasyncd(8)`
daemon.

On the primary *siteA* gateway, add the following.

``` Puppet
class { 'ipsec::sasyncd':
  peer      => $siteA_secondary,
  interface => 'carp42',
  sharedkey => $sharedkey,
}
```

Now on the secondary *siteA* gateway, add the reverse.

``` Puppet
class { 'ipsec::sasyncd':
  peer      => $siteA_primary,
  interface => 'carp42',
  sharedkey => $sharedkey,
}
```

This builds out the configuration for `sasyncd.conf(5)` and manages the
associated service.  The above will configure the service to synchronize
Security Associations between two gateways, using the status of the `carp42`
interface to determine who is master and who is slave at any given time.  You
will need to make sure that TCP port 500 is open from the peer.


# Todo
* manage the isakmpd listen addresses.

