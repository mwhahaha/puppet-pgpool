# == Type: pgpool::hba
#
# This is a resource to manage pgpool_hba entries. It requires
# the pg_hba provider that is available from domcleal-augeasproviders
# Additional examples about how to use this can be found here:
# https://github.com/hercules-team/augeasproviders/blob/master/docs/examples/pg_hba.md
#
# === Parameters
#
# [*name*]
# String. This is the name of the item we will be managing.
#
# [*ensure*]
# String. This is the setting to manage the existance of our
# configuration item in the file.
# Defaults to <tt>present</tt>
#
# [*type*]
# String. This is the type option for the pool_hba.conf item.
# Defaults to <tt>undef</tt>
#
# [*database*]
# String. This is the database option for the pool_hba.conf item.
# Defaults to <tt>undef</tt>
#
# [*user*]
# String. This is the user option for the pool_hba.conf item.
# Defaults to <tt>undef</tt>
#
# [*address*]
# String. This is the address option for the pool_hba.conf item.
# Defaults to <tt>undef</tt>
#
# [*auth_method*]
# String. This is the method option for the pool_hba.conf item.
# Defaults to <tt>undef</tt>
#
# [*options*]
# String. This is the options option for the pg_hba type.
# Defaults to <tt>undef</tt>
#
# [*position*]
# String. See augeasproviders documentation for this one.
# Defaults to <tt>undef</tt>
#
# [*target*]
# String. This is the file path to modify. This variable
# allows you to override the default which comes from
# $pgpool::config::pool_hba_file if $target is undef.
# Defaults to <tt>undef</tt>
#
# === Variables
#
# N/A
#
# === Examples
#
#  pgpool::hba { 'myuser_on_appnode31':
#    ensure      => present,
#    type        => 'host',
#    database    => 'all',
#    user        => 'myuser',
#    address     => '192.168.101.31/32',
#    auth_method => 'md5',
#  }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
define pgpool::hba (
  $ensure      = present,
  $type        = undef,
  $database    = undef,
  $user        = undef,
  $address     = undef,
  $auth_method = undef,
  $options     = undef,
  $position    = undef,
  $target      = undef,
) {

  $target_real = $target ? {
    undef   => $pgpool::config::pool_hba_file,
    default => $target,
  }

  pg_hba { $name:
    ensure   => $ensure,
    type     => $type,
    database => $database,
    user     => $user,
    address  => $address,
    method   => $auth_method,
    options  => $options,
    position => $position,
    target   => $target_real,
    notify   => Exec['pgpool_reload'],
    before   => Service['pgpool']
  }
}
