# == Class: pgpool
#
# This pgpool class can be used to control the installation and configuration
# of pgpool for postgresql.
#
# === Parameters
#
# [*ensure*]
#   String. This value controls if the pacakge and various configuration files
#   should be present or absent. Valid values are present, latest and absent.
#   Defaults to <tt>present</tt>
#
# [*manage_service_user*]
#   Boolean. This value controls if you want this class to ensure the service
#   user exists.
#   Defaults to <tt>false</tt>
#
# [*config_dir*]
#   String. This is the path to the config dir for pgpool.  If not provided,
#   it will default to <tt>/etc/pgpool-II-93</tt>.
#   Defaults to <tt>undef</tt>
#
# [*package_name*]
#   String. This is the package name to install for pgpool.  If not provided,
#   it will default to <tt>pgpool-II-93</tt>.
#   Defaults to <tt>undef</tt>.
#
# [*postgresql_version*]
#   String.  This is the postgresql version you are running.  It is used to
#   build the default package name and configuration dirs.  If not provided,
#   it will default to <tt>9.3</tt>.
#   Defaults to <tt>undef</tt>.
#
# [*service_ensure*]
#   String. This is controls if the service should be running or stopped.
#   Defaults to <tt>running</tt>
#
# [*service_enable*]
#   Boolean. This controls if the service should autostart on boot.
#   Defaults to <tt>true</tt>
#
# [*service_user*]
#   String. This is the user that the service runs as and the files should be
#   owned by.  The pgpool service scripts use postgres.
#   Defaults to <tt>postgres</tt>
#
# [*service_group*]
#   String. This is the group that the service runs as and the files should be
#   owned by.  The pgpool service scripts use postgres.
#   Defaults to <tt>postgres</tt>
#
# === Variables
#
#  N/A
#
# === Examples
#
#  To install:
#  class { pgpool:
#  }
#
#  To remove:
#  class { pgpool:
#    ensure => absent,
#  }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool (
  $ensure              = present,
  $manage_service_user = false,
  $config_dir          = undef,
  $package_name        = undef,
  $postgresql_version  = undef,
  $service_ensure      = running,
  $service_enable      = true,
  $service_name        = undef,
  $service_user        = 'postgres',
  $service_group       = 'postgres',
) {
  anchor { 'pgpool::begin': }
  anchor { 'pgpool::end': }

  if !($service_ensure in [running, stopped]) {
    fail("service_ensure must be either running or stopped, '${service_ensure}' is not valid")
  }



  # setup our ensure values for various types
  $file_ensure = $ensure ? {
    absent  => absent,
    default => file,
  }

  $directory_ensure = $ensure ? {
    absent  => absent,
    default => directory,
  }


  $service_ensure_real = $ensure ? {
    absent  => stopped,
    default => $service_ensure
  }

  $service_enable_real = $ensure ? {
    absent  => false,
    default => $service_enable
  }

  $postgresql_version_real = $postgresql_version ? {
    undef   => '9.3',
    default => $postgresql_version
  }

  # determine what version of the package to install
  $postgresql_version_short = $postgresql_version_real ? {
    undef   => '93',
    default => regsubst($postgresql_version_real,'\.','')
  }

  $package_name_real = $pgpool::package_name ? {
    undef   => $::osfamily ? {
      /RedHat/ => "pgpool-II-${postgresql_version_short}",
      default  => 'pgpool2',
    },
    default => $pgpool::package_name,
  }

  $service_name_real = $pgpool::service_name ? {
    undef   => $package_name_real,
    default => $pgpool::service_name
  }

  class { 'pgpool::package': }
  class { 'pgpool::service': }
  class { 'pgpool::config': }

  if ($ensure == absent) {
    Anchor['pgpool::begin'] ->
      Class['pgpool::service'] ->
      Class['pgpool::config'] ->
      Class['pgpool::package']
  } else {
    Anchor['pgpool::begin'] ->
      Class['pgpool::package'] ->
      Class['pgpool::config'] ->
      Class['pgpool::service']

  }
}
