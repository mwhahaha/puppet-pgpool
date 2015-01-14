# == Class: pgpool::config::masterslave
#
# This class configures the master/slave configuration items for pgpool in the
# pgpool.conf file.  pgpool::config::backend should be used to configure the
# backend servers for the master/slave configuration.
#
# === Parameters
#
# [*master_slave_mode*]
#   String. Enable or disable the master/slave mode in pgpool.
#   Defaults to <tt>off</tt>.
#
# [*master_slave_sub_mode*]
#   String. This is the type of replication used. Should be one of
#   <tt>slony</tt> or <tt>stream</tt>.
#   Defaults to <tt>stream</tt>.
#
# [*sr_check_period*]
#   Integer. The period to check the replication status. 0 will disable it.
#   Defaults to <tt>0</tt>.
#
# [*sr_check_user*]
#   String. The user to use for replication checks.
#   Defaults to <tt>pgpool</tt>.
#
# [*sr_check_password*]
#   String. The password to use for the replication checks.
#   Defaults to <tt>''</tt>.
#
# [*delay_threshold*]
#   Integer. The maximum tolerated replication delay of teh standy against the
#   primary server in WAL bytes.
#   Defaults to <tt>1000000</tt>.
#
# [*follow_master_command*]
#   String. The command to run in master/slave streaming rplicaiton mode only
#   after a master failover.
#   Defaults to <tt>''</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config::masterslave':
#   master_slave_mode     => 'on',
#   master_slave_sub_mode => 'steam',
#   sr_check_period       => '5',
#   sr_check_user         => 'myuser',
#   sr_check_password     => 'mypassword',
#   delay_threshold       => 1000000,
# }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
# === Copyright
#
# Copyright 2015 Alex Schultz, unless otherwise noted.
#
class pgpool::config::masterslave (
  $master_slave_mode     = 'off',
  $master_slave_sub_mode = 'stream',
  $sr_check_period       = 0,
  $sr_check_user         = 'pgpool',
  $sr_check_password     = '',
  $delay_threshold       = 10000000,
  $follow_master_command = '',
) {

  $masterslave_config = {
    'master_slave_mode'     => { value => $master_slave_mode },
    'master_slave_sub_mode' => { value => $master_slave_sub_mode },
    'sr_check_period'       => { value => $sr_check_period },
    'sr_check_user'         => { value => $sr_check_user },
    'sr_check_password'     => { value => $sr_check_password },
    'delay_threshold'       => { value => $delay_threshold },
    'follow_master_command' => { value => $follow_master_command },
  }

  $masterslave_defaults = {
    ensure => present
  }

  create_resource(pgpool::config::val, $masterslave_config, $masterslave_defaults)
}
