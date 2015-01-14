# == Class: pgpool::config::service
#
# This configures service related configuration items for pgpool in the
# pgpool.conf
#
# === Parameters
#
# [*pid_filename*]
#   String. This is the location of the pid file for the pgpool process.
#   Defaults to <tt>/var/run/pgpool.pid</tt>.
#
# [*logdir*]
#   String. This is the log directory for the pgpool process.
#   Defaults to <tt>/var/log/pgpool</tt>.
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
# === Copyright
#
# Copyright 2015 Alex Schultz, unless otherwise noted.
#
class pgpool::config::service (
  $pid_filename = '/var/run/pgpool.pid',
  $logdir       = '/var/log/pgpool',
) {

  $service_config = {
    'pid_filename' => { value => $pid_filename },
    'logdir'       => { value => $logdir },
  }

  $service_defaults = {
    ensure => present
  }

  create_resource(pgpool::config::val, $service_config, $service_defaults)
}
