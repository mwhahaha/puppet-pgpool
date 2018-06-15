# == Class: pgpool::service
#
# This is the pgpool service class. It controls the service and provides an
# exec that can be used to reload pgpool.
#
# === Parameters
#
# N/A
#
# === Variables
#
# [*service_name_real*]
#   String. This is the service name that is configured by the main pgpool
#   class.
#
# [*service_ensure_real*]
#   String. This is the ensure value for the service that is set in the main
#   pgpool class.
#
# [*service_enable_real*]
#   Boolean. This is the service enable value for the service that is set in
#   the main pgpool class.
#
# === Examples
#
# N/A
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool::service {
  if $caller_module_name != $module_name {
    fail('pgpool::service should only be called via the pgpool class')
  }

  $pgpool_service_name = $::pgpool::service_name_real

  if $::osfamily == 'FreeBSD' {
    $service_enable = $::pgpool::service_enable_real ? {
      false   => 'NO',
      default => 'YES',
    }
    file { '/etc/rc.conf.d/pgpool':
      owner   => 'root',
      group   => 'wheel',
      mode    => '0644',
      content => "pgpool_enable=\"${service_enable}\"\npgpool_user=\"${::pgpool::service_user}\"\n",
    }
    service { 'pgpool':
      ensure => $::pgpool::service_ensure_real,
      name   => $pgpool_service_name,
    }
  }
  else {
    service { 'pgpool':
      ensure => $::pgpool::service_ensure_real,
      name   => $pgpool_service_name,
      enable => $::pgpool::service_enable_real
    }
  }

  exec { 'pgpool_reload':
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin',
    command     => 'pgpool reload',
    require     => Service['pgpool'],
    refreshonly => true,
  }
}
