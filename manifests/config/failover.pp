# == Class: pgpool::config::failover
#
# This class allows for the configuration of the failover and recovery options
# in the pgpool.conf file.
#
# === Parameters
#
# [*failover_command*]
# [*failback_command*]
# [*fail_over_on_backend_error*]
# [*search_primary_node_timeout*]
# [*recovery_user*]
# [*recovery_password*]
# [*recovery_1st_stage_command*]
# [*recovery_2nd_stage_command*]
# [*recovery_timeout*]
# [*client_idle_limit_in_recover*]
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
class pgpool::config::failover (
  $failover_command              = '',
  $failback_command              = '',
  $fail_over_on_backend_error    = 'on',
  $search_primary_node_timeout   = 10,
  $recovery_user                 = 'nobody',
  $recovery_password             = '',
  $recovery_1st_stage_command    = '',
  $recovery_2nd_stage_command    = '',
  $recovery_timeout              = 90,
  $client_idle_limit_in_recovery = 0,
) {

  $failover_config = {
    'failover_command'              => { value => $failover_command },
    'failback_command'              => { value => $failback_command },
    'fail_over_on_backend_error'    => { value => $fail_over_on_backend_error },
    'search_primary_node_timeout'   => { value => $search_primary_node_timeout },
    'recovery_user'                 => { value => $recovery_user },
    'recovery_password'             => { value => $recovery_password },
    'recovery_1st_stage_command'    => { value => $recovery_1st_stage_command },
    'recovery_2nd_stage_command'    => { value => $recovery_2nd_stage_command },
    'recovery_timeout'              => { value => $recovery_timeout },
    'client_idle_limit_in_recovery' => { value => $client_idle_limit_in_recovery },
  }

  $failover_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $failover_config, $failover_defaults)
}
