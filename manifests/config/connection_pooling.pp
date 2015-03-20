# == Class: pgpool::config::connection_pooling
#
# This class allows for the configuration of connection pooling items within the
# pgpool.conf.
#
# === Parameters
#
# [*connection_cache*]
#   String. Activate connection pools
#   Defaults to <tt>on</tt>.
#
# [*reset_query_list*]
#   String. Semicolon separated list of queries to be issued at the end of a session
#   Defaults to <tt>ABORT; DISCARD ALL</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config::connection_pooling':
#   connection_cache => 'off',
# }
#
# === Authors
#
# Oskar Malnowicz <oskar@malnowicz.com>
#
class pgpool::config::connection_pooling (
  $connection_cache = 'on',
  $reset_query_list = 'ABORT; DISCARD ALL',
) {

  $connection_pooling_config = {
    'connection_cache'       => { value => $connection_cache },
    'reset_query_list        => { value => $reset_query_list },
  }

  $connection_pooling_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $connection_pooling_config, $connection_pooling_defaults)
}
