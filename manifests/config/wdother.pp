# == Type: pgpool::config::wdother
#
# This type exposes a way to set additional the other_pgpool_* options into the
# configuration for pgpool for the watchdog functionality
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
# [*wd_port*]
#   Integer. This is the wd port on the other host.
#   Defaults to <tt>1</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
#  pgpool::config::wdother { 'host1':
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
define pgpool::config::wdother (
  $ensure   = present,
  $id       = 0,
  $hostname = 'localhost',
  $port     = 9999,
  $wd_port  = 9000,
) {

  $wdother_config = {
    "other_pgpool_hostname${id}" => { value => $hostname },
    "other_pgpool_port${id}"     => { value => $port },
    "other_wd_weight${id}"       => { value => $wd_port },
  }

  $wdother_defaults = {
    ensure => $ensure
  }

  create_resource(pgpool::config::val, $wdother_config, $wdother_defaults)
}
