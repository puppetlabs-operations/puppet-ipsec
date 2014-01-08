ipsec::sa { "something_useful_here":
  local_router   => $local_router,
  remote_router  => $remote_router,
  local_network  => $local_network,
  remote_network => $remote_network,
  key            => $key,
}
