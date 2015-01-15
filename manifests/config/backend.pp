# == Type: pgpool::config::backend
#
# This type exposes a way to set additional backends into the configuration for
# pgpool.
#
# === Parameters
#
# [*ensure*]
#   String. This controls if the backend should be in the config file or not.
#   It should be one of <tt>present</tt> or <tt>absent<tt>.
#   Defaults to <tt>present</tt>.
#
# [*id*]
#   Integer. This is the id for the backend. It is used to create the variable
#   names.  It needs to be unique for each backend configured.
#   Defaults to <tt>0</tt>.
#
# [*hostname*]
#   String. This is the hostname of the backend.
#   Defaults to <tt>localhost</tt>.
#
# [*port*]
#   Integer. This is the port to connect to for the backend.
#   Defaults to <tt>5432</tt>.
#
# [*weight*]
#   Integer. This is the weight to be configured for this backend.
#   Defaults to <tt>1</tt>.
#
# [*data_directory*]
#   String. This is the data directory of the backend server.
#   Defaults to <tt>/var/lib/pgsql/9.3/data</tt>.
#
# [*flag*]
#   String. This is the backend flag for the backend system. It should be one
#   of <tt>ALLOW_TO_FAILOVER</tt> or <tt>DISALLOW_TO_FAILOVER</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
#  pgpool::config::backend { 'host1':
#    id       => 0,
#    hostname => 'host1.example.com',
#  }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
# === Copyright
#
# Copyright 2015 Alex Schultz, unless otherwise noted.
#
define pgpool::config::backend (
  $ensure         = present,
  $id             = 0,
  $hostname       = 'localhost',
  $port           = 5432,
  $weight         = 1,
  $data_directory = '/var/lib/pgsql/9.3/data',
  $flag           = 'ALLOW_TO_FAILOVER',
) {

  $backend_config = {
    "backend_hostname${id}"        => { value => $hostname },
    "backend_port${id}"            => { value => $port },
    "backend_weight${id}"          => { value => $weight },
    "backend_data_directory${id}"  => { value => $data_directory },
    "backend_flag${id}"            => { value => $flag },
  }

  $backend_defaults = {
    ensure => $ensure
  }

  create_resources(pgpool::config::val, $backend_config, $backend_defaults)
}
