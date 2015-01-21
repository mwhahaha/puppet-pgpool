# == Class: pgpool::config::pools
#
# This class configures the pool related items for pgpool in the pgpool.conf
#
# === Parameters
#
# [*num_init_children*]
#   Intger. The number of preforked pgpool-II server processes.
#   Defaults to <tt>32</tt>.
#
# [*max_pool*]
#   Integer. The max number of cached connections in the pgpool-II children
#   processes.
#   Defaults to <tt>4</tt>.
#
# [*child_life_time*]
#   Integer. The cached connections expiration time in seconds.
#   Defaults to <tt>300</tt>.
#
# [*child_max_connections*]
#   Integer. The pgpool child process will be terminated after this many connections.
#   Defaults to <tt>0</tt>.
#
# [*connection_life_time*]
#   Integer. Cached connections expiration time in se4conds.
#   Defaults to <tt>0</tt>.
#
# [*reset_query_list*]
#   String. The SQL commands to be sent to reset the connection on the backend
#   when exiting a session.
#   Defaults to <tt>ABORT; DISCARD ALL</tt>.
#
# [*client_idle_limit*]
#   Integer. The time to disconnect an idle connectionf or.
#   Defaults to <tt>0</tt>.
#
# [*enable_pool_hba*]
#   String. Use the pool_hba.conf for client authentication.
#   Defaults to <tt>off</tt>.
#
# [*pool_passwd*]
#   String. The file name of the pool_passwd for md5 auth.
#   Defaults to <tt>pool_passwd</tt>.
#
# [*authentication_timeout*]
#   Integer. The timeout for pgpool authentication.
#   Defaults to <tt>60</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
# N/A
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool::config::pools (
  $num_init_children      = 32,
  $max_pool               = 4,
  $child_life_time        = 300,
  $child_max_connections  = 0,
  $connection_life_time   = 0,
  $reset_query_list       = 'ABORT; DISCARD ALL',
  $client_idle_limit      = 0,
  $enable_pool_hba        = 'off',
  $pool_passwd            = 'pool_passwd',
  $authentication_timeout = 60,
) {

  $pools_config = {
    'num_init_children'      => { value => $num_init_children },
    'max_pool'               => { value => $max_pool },
    'child_life_time'        => { value => $child_life_time },
    'child_max_connections'  => { value => $child_max_connections },
    'connection_life_time'   => { value => $connection_life_time },
    'reset_query_list'       => { value => $reset_query_list },
    'client_idle_limit'      => { value => $client_idle_limit },
    'enable_pool_hba'        => { value => $enable_pool_hba },
    'pool_passwd'            => { value => $pool_passwd },
    'authentication_timeout' => { value => $authentication_timeout },
  }

  $pools_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $pools_config, $pools_defaults)
}
