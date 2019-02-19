# == Class: pgpool::config::failover
#
# This class allows for the configuration of the failover and recovery options
# in the pgpool.conf file.
#
# === Parameters
#
# [*failover_command*]
#  String. The command to run when a node is detached.
#  Defaults to <tt></tt>.
#
# [*failback_command*]
#  String. The command to run when a node is attached.
#  Defaults to <tt></tt>.
#
# [*failover_on_backend_error*]
#  String. If true and an error occurs when communicating with the backend,
#  pgpool will trigger the failover procedure.
#  Defaults to <tt>on</tt>.
#
# [*detach_false_primary*]
#  String. If set to on, detach false primary node. The default is off.
#  This parameter is only valid in streaming replication mode and for
#  PostgreSQL 9.6 or after since this feature uses pg_stat_wal_receiver.
#  If PostgreSQL 9.5.x or older version is used, no error is raised, just the feature is ignored.
#  Defaults to <tt>off</tt>.
#
# [*search_primary_node_timeout*]
#  Integer. The max amoutn of time in seconds to search for a primary node when
#  in a failover scenario.
#  Defaults to <tt>10</tt>.
#
# [*recovery_user*]
#  String. The postgresql username for online recovery.
#  Defaults to <tt>nobody</tt>.
#
# [*recovery_password*]
#  String. The password for the user for online recovery.
#  Defaults to <tt></tt>.
#
# [*recovery_1st_stage_command*]
#  String. The command to be run on the master servier at the first stage
#  of online recovery.
#  Defaults to <tt></tt>.
#
# [*recovery_2nd_stage_command*]
#  String. The command to be run on the master at the second stage of online
#  recovery.
#  Defaults to <tt></tt>.
#
# [*recovery_timeout*]
#  Integer. During recovery, pgpool won't accept connections so this is a
#  timeout value to wait during recovery before it gives up and accepts
#  connections.
#  Defaults to <tt>90</tt>.
#
# [*client_idle_limit_in_recovery*]
#  Integer. Time to disconnect idle connections during online recovery.
#  Defaults to <tt>0</tt>.
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
class pgpool::config::failover (
  $failover_command              = '',
  $failback_command              = '',
  $failover_on_backend_error     = 'on',
  $detach_false_primary          = 'off',
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
    'failover_on_backend_error'     => { value => $failover_on_backend_error },
    'detach_false_primary'          => { value => $detach_false_primary},
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
