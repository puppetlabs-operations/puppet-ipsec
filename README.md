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

