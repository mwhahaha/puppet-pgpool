# == Class: pgpol::monitor
#
# This is a class to pull in the custom pgpool monitoring for monitoring
# pgpool instances.  You should specify the connection information for the
# database and to talk to pgpool via pcp.  The db test will attempt to create
# and write to a temp table to ensure that write connections work as well as
# doing a "SELECT 1" to test read connections. The pcp monitoring will return
# the total number of backends, number available and number of processes.
#
# See https://github.com/rackerlabs/pgpool-monitor
#
# == Parameters
#
# [*ensure*]
#  This is one of <tt>present</tt>, <tt>latest</tt>, or <tt>absent</tt>.
#  Defaults to <tt>latest</tt>.
#
# [*db_host*]
#  String. The host to connect to pgpool on for postgresql connectons.
#  Defaults to <tt>localhost</tt>
#
# [*db_port*]
#  Integer. The port to connect to pgpool on for the postgresql connections.
#  Defaults to <tt>9999</tt>.
#
# [*db_database*]
#  String. The database to connect to and try to read/write.
#  Defaults to <tt>postgres</tt>.
#
# [*db_user*]
#  String. The user to connect to pgpool as for postgresql queries.
#  Defaults to <tt>zabbix</tt>.
#
# [*db_password*]
#  String. The password use to connect to pgpool as for postgresql queries.
#  Defaults to <tt></tt>.
#
# [*pcp_timeout*]
#  Integer. The timeout used to connect to the pcp port of pgpool.
#  Defaults to <tt>9898</tt>.
#
# [*pcp_host*]
#  String. The host used to connect to the pcp.
#  Defaults to <tt>localhost</tt>.
#
# [*pcp_port*]
#  Integer. The port used to connect to pcp.
#  Defaults to <tt>9898</tt>.
#
# [*pcp_user*]
#  String. The user used to connect to pcp.
#  Defaults to <tt>zabbix</tt>.
#
# [*pcp_password*]
#  String. The password used to connect to pcp.
#  Defaults to <tt>zabbix</tt>.
#
# === Examples
#
# include pgpool::monitor
#
# class { 'pgpool::monitor':
#   ensure => absent
# }
#
# === Authors
#
# * Alex Schultz <mailto:alex.schultz@rackspace.com>
#
class pgpool::monitor (
  $ensure           = latest,
  $db_host          = 'localhost',
  $db_port          = 9999,
  $db_database      = 'postgres',
  $db_user          = 'zabbix',
  $db_password      = '',
  $pcp_timeout      = 10,
  $pcp_host         = 'localhost',
  $pcp_port         = 9898,
  $pcp_user         = 'zabbix',
  $pcp_password     = 'zabbix',
) {

  if $ensure == absent {
    $file_ensure = absent
    $ini_ensure = absent
  } else {
    $file_ensure = file
    $ini_ensure = present
  }

  package { 'pgpool_monitor':
    ensure => $ensure,
  }

  $config_file = '/etc/pgpool_monitor.cfg'
  file { $config_file:
    ensure  => $file_ensure,
    owner   => 'zabbix',
    group   => 'zabbix',
    require => Package['pgpool_monitor'],
  }

  $config_defaults = {
    'ensure' => $ini_ensure,
    'path'   => $config_file
  }

  $config_settings = {
    'db_host' => {
      section => 'db',
      setting => 'host',
      value   => $db_host
    },
    'db_port' => {
      section => 'db',
      setting => 'port',
      value   => $db_port
    },
    'db_database' => {
      section => 'db',
      setting => 'database',
      value   => $db_database
    },
    'db_user' => {
      section => 'db',
      setting => 'user',
      value   => $db_user
    },
    'db_password' => {
      section => 'db',
      setting => 'password',
      value   => $db_password
    },
    'pcp_timeout' => {
      section => 'pcp',
      setting => 'timeout',
      value   => $pcp_timeout
    },
    'pcp_host' => {
      section => 'pcp',
      setting => 'host',
      value   => $pcp_host
    },
    'pcp_port' => {
      section => 'pcp',
      setting => 'port',
      value   => $pcp_port
    },
    'pcp_user' => {
      section => 'pcp',
      setting => 'user',
      value   => $pcp_user
    },
    'pcp_password' => {
      section => 'pcp',
      setting => 'password',
      value   => $pcp_password
    },
  }
  if $file_ensure == file {
    create_resources(ini_setting, $config_settings, $config_defaults)
  }
}
