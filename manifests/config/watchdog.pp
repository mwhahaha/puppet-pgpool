# == Class: pgpool::config::watchdog
#
# This configures the watchdog functions of pgpool in the pgpool.conf.  It
# should be used in combination with pgpool::config::heartbeat to configure
# the other heartbeat backends.
#
# === Parameters
#
# [*use_watchdog*]
#   String. Enables the watchdog in pgpool.
#   Defaults to <tt>off</tt>.
#
# [*trusted_servers*]
#   String. List of trusted servers for the watchdog.
#   Defaults to <tt></tt>.
#
# [*ping_path*]
#   String. The path too where ping lives.
#   Defaults to <tt>/bin</tt>.
#
# [*wd_hostname*]
#   String. the IP or hostname of the server.
#   Defaults to <tt></tt>.
#
# [*wd_port*]
#   Integer. The port for the watchdog.
#   Defaults to <tt>9000</tt>.
#
# [*wd_authkey*]
#   String. The auth key to use for the watchdog.
#   Defaults to <tt></tt>.
#
# [*delegate_IP*]
#   String. The virtual IP for pgpool.
#   Defaults to <tt></tt>.
#
# [*ifconfig_path*]
#   String. The path to ifconfig.
#   Defaults to <tt>/sbin</tt>.
#
# [*if_up_cmd*]
#   String. The ifup cmd to use for the vip.
#   Defaults to <tt>ifconfig eth0:0 inet $_IP_$ netmask 255.255.255.0</tt>.
#
# [*if_down_cmd*]
#   String. The ifdown cmd to use for the vip.
#   Defaults to <tt>ifconfig eth0:0 down</tt>.
#
# [*arping_path*]
#   String. The path to arping.
#   Defaults to <tt>/usr/bin</tt>.
#
# [*arping_cmd*]
#   String. the arping command to arp the vip.
#   Defaults to <tt>arping -U $_IP_$ -w 1</tt>.
#
# [*clear_memqcache_onescalation*]
#   String. Should the watchdog clear the query cache when pgpool escalates to
#   active.
#   Defaults to <tt>on</tt>.
#
# [*wd_escalation_command*]
#   String. The command that the watchdog should run when it escalates to
#   active.
#   Defaults to <tt></tt>.
#
# [*wd_lifecheck_method*]
#   String. The way the watchdog communicates with others.  Should be one of
#   <tt>query</tt> or <tt>heartbeat</tt>.
#   Defaults to <tt>heartbeat</tt>.
#
# [*wd_interval*]
#   Integer. The interval to check the other pgool instances.
#   Defaults to <tt>10</tt>.
#
# [*wd_heartbeat_port*]
#   Integer. The port number to receive heartbeat signals.
#   Defaults to 9694.
#
# [*wd_heartbeat_keepalive*]
#   Integer. The interval time of keepalives.
#   Defaults to <tt>2</tt>.
#
# [*wd_heartbeat_deadtime*]
#   Integer. How long to wait before considering someone dead.
#   Defaults to <tt>30</tt>.
#
# [*wd_life_point*]
#   Integer.  The times to retry a d failed live check.
#   Defaults to <tt>3</tt>.
#
# [*wd_lifecheck_query*]
#   String. The query to use for checks.
#   Defaults to <tt>SELECT 1</tt>.
#
# [*wd_lifecheck_dbname*]
#   String. The db to use for the life check query.
#   Defaults to <tt>template1</tt>.
#
# [*wd_lifecheck_user*]
#   String. The user to use for the life check query.
#   Defaults to <tt>nobody</tt>.
#
# [*wd_lifecheck_password*]
#   String. The password to use for the lfie check query.
#   Defaults to <tt></tt>.
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
class pgpool::config::watchdog (
  $use_watchdog                  = 'off',
  $trusted_servers               = '',
  $ping_path                     = '/bin',
  $wd_hostname                   = '',
  $wd_port                       = 9000,
  $wd_authkey                    = '',
  $delegate_IP                   = '',
  $ifconfig_path                 = '/sbin',
  $if_up_cmd                     = 'ifconfig eth0:0 inet $_IP_$ netmask 255.255.255.0',
  $if_down_cmd                   = 'ifconfig eth0:0 down',
  $arping_path                   = '/usr/sbin',
  $arping_cmd                    = 'arping -U $_IP_$ -w 1',
  $clear_memqcache_on_escalation = 'on',
  $wd_escalation_command         = '',
  $wd_lifecheck_method           = 'heartbeat',
  $wd_interval                   = 10,
  $wd_heartbeat_port             = 9694,
  $wd_heartbeat_keepalive        = 2,
  $wd_heartbeat_deadtime         = 30,
  $wd_life_point                 = 3,
  $wd_lifecheck_query            = 'SELECT 1',
  $wd_lifecheck_dbname           = 'template1',
  $wd_lifecheck_user             = 'nobody',
  $wd_lifecheck_password         = '',
) {

  $watchdog_config = {
    'use_watchdog'                  => { value => $use_watchdog },
    'trusted_servers'               => { value => $trusted_servers },
    'ping_path'                     => { value => $ping_path },
    'wd_hostname'                   => { value => $wd_hostname },
    'wd_port'                       => { value => $wd_port },
    'wd_authkey'                    => { value => $wd_authkey },
    'delegate_IP'                   => { value => $delegate_IP },
    'ifconfig_path'                 => { value => $ifconfig_path },
    'if_up_cmd'                     => { value => $if_up_cmd },
    'if_down_cmd'                   => { value => $if_down_cmd },
    'arping_path'                   => { value => $arping_path },
    'arping_cmd'                    => { value => $arping_cmd },
    'clear_memqcache_on_escalation' => { value => $clear_memqcache_on_escalation },
    'wd_escalation_command'         => { value => $wd_escalation_command },
    'wd_lifecheck_method'           => { value => $wd_lifecheck_method },
    'wd_interval'                   => { value => $wd_interval },
    'wd_heartbeat_port'             => { value => $wd_heartbeat_port },
    'wd_heartbeat_keepalive'        => { value => $wd_heartbeat_keepalive },
    'wd_heartbeat_deadtime'         => { value => $wd_heartbeat_deadtime },
    'wd_life_point'                 => { value => $wd_life_point },
    'wd_lifecheck_query'            => { value => $wd_lifecheck_query },
    'wd_lifecheck_dbname'           => { value => $wd_lifecheck_dbname },
    'wd_lifecheck_user'             => { value => $wd_lifecheck_user },
    'wd_lifecheck_password'         => { value => $wd_lifecheck_password },
  }

  $watchdog_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $watchdog_config, $watchdog_defaults)
}
