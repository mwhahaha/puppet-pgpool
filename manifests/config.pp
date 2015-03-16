# == Class: pgpool::config
#
# This class ensure the sysconfig and pgpool.conf files exist.  It also pulls
# in the pgpool augeas lense so that the pgpool::config::val resource can
# use that lens to manipulate the pgpool.conf files.
#
# === Parameters
#
# N/A
#
# === Variables
#
# [*pgpool_service_name*]
#  This class assumes that the pgpool_service_name variable from
#  pgpool::service  has been configured.
#
# [*service_user*]
#  This class assumes that the service_user variable from pgpool has been
#  configured.
#
# [*service_group*]
#  This class assumes that the service_group variable from pgpool has been
#  configured.
#
# [*log_user*]
#  This class assumes that the log_user variable from pgpool has been
#  configured.
#
# [*log_group*]
#  This class assumes that the log_group variable from pgpool has been
#  configured.
#
# === Examples
#
# N/A
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool::config {
  if $caller_module_name != $module_name {
    fail('pgpool::config should only be called via the pgpool class')
  }

  $config_dir = $::pgpool::config_dir ? {
    undef   => "/etc/${::pgpool::service::pgpool_service_name}",
    default => $::pgpool::config_dir
  }

  $defaults_dir = $::osfamily ? {
    /RedHat/ => '/etc/sysconfig',
    /Debian/ => '/etc/default',
    default  => '/etc/sysconfig',
  }

  $pgpool_sysconfig_file = "${defaults_dir}/${::pgpool::service::pgpool_service_name}"
  $pgpool_config_file = "${config_dir}/pgpool.conf"
  $pool_passwd_file = "${config_dir}/pool_passwd"
  $pcp_file = "${config_dir}/pcp.conf"
  $pool_hba_file = "${config_dir}/pool_hba.conf"
  $log_dir = "/var/log/${::pgpool::service::pgpool_service_name}"

  File {
    owner => $::pgpool::service_user,
    group => $::pgpool::service_group,
    mode  => '0640'
  }

  include augeas

  augeas::lens { 'pgpool':
    ensure      => present,
    lens_source => "puppet:///modules/${module_name}/augeas-pgpool/pgpool.aug",
    test_source => "puppet:///modules/${module_name}/augeas-pgpool/test/test_pgpool.aug",
  }

  file { $pgpool_config_file:
    ensure => $::pgpool::file_ensure,
    notify => Exec['pgpool_reload']
  }

  file { $pgpool_sysconfig_file:
    ensure => $::pgpool::file_ensure,
    notify => Service['pgpool']
  }

  file { $pool_passwd_file:
    ensure => $::pgpool::file_ensure,
    notify => Exec['pgpool_reload']
  }

  file { $pool_hba_file:
    ensure => $::pgpool::file_ensure,
    notify => Exec['pgpool_reload']
  }

  file { $pcp_file:
    ensure => $::pgpool::file_ensure,
    notify => Exec['pgpool_reload']
  }

  file { $log_dir:
    owner  => $::pgpool::log_user,
    group  => $::pgpool::log_group,
    ensure => $::pgpool::directory_ensure
  }
}
