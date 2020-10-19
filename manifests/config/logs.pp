# == Class: pgpool::config::logs
#
# This class allows for the configuration of logging related items within the
# pgpool.conf.
#
# === Parameters
#
# [*log_destination*]
#   String. Where to print the logs to. Can be either <tt>syslog</tt> or
#   <tt>stderr</tt>.
#   Defaults to <tt>stderr</tt>.
#
# [*log_connections*]
#   String. Enabling this will result in all connections being logged.
#   Defaults to <tt>off</tt>.
#
# [*log_statement*]
#   String. Print out each query that is issued.
#   Defaults to <tt>off</tt>.
#
# [*log_per_node_statement*]
#   String. Prints statements for each DB node sperately.
#   Defaults to <tt>off</tt>.
#
# [*log_error_verbosity*]
#   String. How verbose should error messages be?  Should be one of
#   <tt>terse</tt>, <tt>default</tt>, or <tt>verbose</tt>
#   Defaults to <tt>default</tt>.
#
# [*log_standby_delay*]
#   String.  Specifies how to log the replication delay. Should be one of
#   <tt>none</tt>, <tt>always</tt> or <tt>if_over_threshold</tt>.
#   Defaults to <tt>if_over_threshold</tt>.
#
# [*log_min_messages*]
#   String. This controls the message levels that are emitted to log.
#   Defaults to <tt>WARNING</tt>.
#
# [*syslog_facility*]
#   String. This is the syslog facility to send the logs to.
#   Defaults to <tt>LOCAL0</tt>.
#
# [*syslog_ident*]
#   String. This is the process string for syslog.
#   Defaults to <tt>pgpool</tt>.
#
# [*debug_level*]
#   Integer. Set to 1 for debug logging.
#   Defaults to <tt>0</tt>.
#
# [*log_line_prefix*]
#   String. This is a printf-style string that is outputted at the beginning 
#   of each log line.
#   Defaults to <tt>%t: pid% p: </tt>
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config::logs':
#   log_destination => 'syslog',
# }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool::config::logs (
  $log_destination        = 'stderr',
  $log_connections        = 'off',
  $log_statement          = 'off',
  $log_per_node_statement = 'off',
  $log_error_verbosity    = 'default',
  $log_standby_delay      = 'if_over_threshold',
  $log_min_messages       = 'WARNING',
  $syslog_facility        = 'LOCAL0',
  $syslog_ident           = 'pgpool',
  $debug_level            = 0,
  $log_line_prefix        = '%t: pid %p:',
) {

  $logs_config = {
    'log_destination'        => { value => $log_destination },
    'log_connections'        => { value => $log_connections },
    'log_statement'          => { value => $log_statement },
    'log_per_node_statement' => { value => $log_per_node_statement },
    'log_standby_delay'      => { value => $log_standby_delay },
    'log_error_verbosity'    => { value => $log_error_verbosity },
    'log_min_messages'       => { value => $log_min_messages },
    'syslog_facility'        => { value => $syslog_facility },
    'syslog_ident'           => { value => $syslog_ident },
    'debug_level'            => { value => $debug_level },
    'log_line_prefix'        => { value => $log_line_prefix },
  }

  $logs_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $logs_config, $logs_defaults)
}
