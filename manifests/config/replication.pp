# == Class: pgpool::config::replication
#
# This class configures pgpool's replication funcationality in pgpool.conf.
#
# === Parameters
#
# [*replication_mode*]
#   String. Enabling this turns on replicaiton mode.
#   Defaults to <tt>off</tt>.
#
# [*replicate_select*]
#   String. Should selects also be replicated.
#   Defaults to <tt>off</tt>.
#
# [*insert_lock*]
#   String. http://www.pgpool.net/docs/latest/pgpool-en.html#INSERT_LOCK
#   Defaults to <tt>off</tt>.
#
# [*lobj_lock_table*]
#   String. The table name used for large object replication control.
#   Defaults to <tt>''</tt>.
#
# [*replication_stop_on_mismatch*]
#   String. When enabled, if all backends don't return the same packet kind,
#   the backends that differe from most frequent reult set are degenerated.
#   Defaults to <tt>off</tt>.
#
# [*failover_if_affected_tuple_mismatch*]
#   String. When enabled, if backends don't return the same number of affected
#   tuples during an INSER/UPDATE/DELETE, the backends that differ are
#   degerated.
#   Defaults to <tt>off</tt>.
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
class pgpool::config::replication (
  $replication_mode                    = 'off',
  $replicate_select                    = 'off',
  $insert_lock                         = 'off',
  $lobj_lock_table                     = '',
  $replication_stop_on_mismatch        = 'off',
  $failover_if_affected_tuple_mismatch = 'off',
) {

  $replication_config = {
    'replication_mode'                    => { value => $replication_mode },
    'replicate_select'                    => { value => $replicate_select },
    'insert_lock'                         => { value => $insert_lock },
    'lobj_lock_table'                     => { value => $lobj_lock_table },
    'replication_stop_on_mismatch'        => { value => $replication_stop_on_mismatch },
    'failover_if_affected_tuple_mismatch' => { value => $failover_if_affected_tuple_mismatch },
  }

  $replication_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $replication_config, $replication_defaults)
}
