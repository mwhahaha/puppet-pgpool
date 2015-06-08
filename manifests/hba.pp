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
# String. This is the method option for the pool_hba.conf item. Use either this
# parameter or `method` below, but not both. This parameter is named in
# accordance with PostgreSQL's documentation on the `pg_hba.conf` file and
# should be preferred over `method`.
# Defaults to <tt>undef</tt>
#
# [*method*]
# String. This is the method option for the pool_hba.conf item. Use either this
# parameter or `auth_method` above, but not both. This parameter is supported
# for backwards compatibility but should be avoided since it is *not* named in
# accordance with PostgreSQL's documentation on the `pg_hba.conf` file.
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
  $method      = undef,
  $options     = undef,
  $position    = undef,
  $target      = undef,
) {

  $target_real = $target ? {
    undef   => $pgpool::config::pool_hba_file,
    default => $target,
  }

  # Either $auth_method or $method can be used, but not both. Fail loudly if
  # both are set by the user.
  if $auth_method and $method {
    fail ("Pgpool::Hba[${title}]: Cannot specify both \$auth_method and \$method. Please choose one, preferrably \$auth_method.")
  }

  # If $auth_method is not set (undef) use $method as $auth_method_real.
  # $method might also be undef, which is ok; $auth_method_real then becomes
  # undef, too. And if $auth_method is set (not undef), use it.
  $auth_method_real = $auth_method ? {
    undef   => $method,
    default => $auth_method,
  }

  pg_hba { $name:
    ensure   => $ensure,
    type     => $type,
    database => $database,
    user     => $user,
    address  => $address,
    method   => $auth_method_real,
    options  => $options,
    position => $position,
    target   => $target_real,
    notify   => Exec['pgpool_reload'],
    before   => Service['pgpool']
  }
}
