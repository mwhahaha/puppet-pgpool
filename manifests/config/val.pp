# == Type: pgpool::config::val
#
# This resource allows for the manipulation of specific values within a
# configuration file via Augeas.
#
# === Parameters
#
# [*ensure*]
#   String. This controls if the setting should be <tt>present</tt> or
#   <tt>absent</tt> in the configuration file.
#   Defaults to <tt>present</tt>.
#
# [*target*]
#   String. This is the file that we will be working with.
#   Defaults to the pgpool configuration file from the pgpool::config class.
#
# [*value*]
#   Mixed. This is the value to be set for the $name in the config file.
#   Defaults to <tt>undef</tt>.
#
# === Variables
#
# [*name*]
#   String. This is the name of the variable to set within the config file.
#
# [*pgpool_service_name*]
#   String. This is the service name from the pgpool::service class. It is used
#   for the reload command.
#
# [*pgpool_config_file*]
#   String. This is the pgpool.conf file and is pulled from pgpool::config.
#
# === Examples
#
# pgpool::config::val { 'listen_addresses':
#   target => '/etc/pgpool/pgpool.conf',
#   value  => '*',
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
define pgpool::config::val (
  $ensure = present,
  $target = undef,
  $value  = undef,
) {
  $target_real = $target ? {
    undef   => $::pgpool::config::pgpool_config_file,
    default => $target
  }

  $ensure_real = $value ? {
    undef   => absent,
    default => $ensure,
  }

  Augeas {
    incl    => $target_real,
    lens    => 'Pgpool.lns',
    require => Class['pgpool::config'],
    notify  => Exec["${::pgpool::service::pgpool_service_name}_reload"],
    before  => Service[$::pgpool::service::pgpool_service_name]
  }

  case $ensure_real {
    present: {
      augeas { "set pgpool.conf ${name}":
        changes => "set ${name} '${value}'",
      }
    }
    absent: {
      augeas { "rm pgpool.conf ${name}":
        changes => "rm ${name}",
      }
    }
    default: {
      fail("pgpool::config::val - Invalid value of ensure '${ensure}'")
    }
  }
}
