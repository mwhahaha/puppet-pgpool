# == Type: pgpool::pool_passwd
#
# This resource allows for the manipulation of users and password hashes within
# a pool_passwd file via Augeas.
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
#   Defaults to the pool_passwd_file from the pgpool::config class.
#
# [*password_hash*]
#   String. This should be the password md5 for the user.
#   Defaults to <tt>undef</tt>.
#
# === Variables
#
# [*name*]
#   String. This is the name of the user to manage.
#
# [*pgpool_service_name*]
#   String. This is the service name from the pgpool::service class. It is used
#   for the reload command.
#
# [*pool_passwd_file*]
#   String. This is the pool_passwd file and is pulled from pgpool::config.
#
# === Examples
#
# pgpool::config::val { 'myuser':
#   target        => '/etc/pgpool/my_pool_passwd'
#   password_hash => md5('secretpassword'),
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
define pgpool::pool_passwd (
  $ensure        = present,
  $target        = undef,
  $password_hash = undef,
) {
  $target_real = $target ? {
    undef   => $::pgpool::config::pool_passwd_file,
    default => $target
  }

  $ensure_real = $password_hash ? {
    undef   => absent,
    default => $ensure,
  }

  Augeas {
    incl    => $target_Real,
    lens    => 'Pgpool_Passwd.lns',
    require => Exec["${::pgpool::service::pgpool_service_name}_reload"]
  }

  case $ensure_real {
    present: {
      augeas { "set pool_passwd ${name}":
        changes => "set ${name} '${password_hash}'",
      }
    }
    absent: {
      augeas { "rm pgool_passwd ${name}":
        changes => "rm ${name}",
      }
    }
    default: {
      fail("pgpool::pool_passwd - Invalid value of ensure '${ensure}'")
    }
  }
}
