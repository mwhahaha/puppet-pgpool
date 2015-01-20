# == Class: pgpool::package
#
# This class controls the installation of the pgpool software.
#
# === Parameters
#
# N/A
#
# === Variables
#
# [*package_name*]
#   String. This is the package name which is configured by the main pgpool
#   class.
#
# [*ensure*]
#   String.  This is the pgpool ensure variable. It controls the package ensure
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
class pgpool::package {
  if $caller_module_name != $module_name {
    fail('pgpool::package should only be called via the pgpool class')
  }

  $pgpool_package_name = $::pgpool::package_name_real
  package { 'pgpool':
    ensure => $::pgpool::ensure,
    name   => $pgpool_package_name,
  }
}
