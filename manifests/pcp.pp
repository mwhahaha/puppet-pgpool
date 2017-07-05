# == Type: pgpool::pcp
#
# This resource allows for the manipulation of users and password hashes within
# a pcp.conf file via Augeas.
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
# === Examples
#
# pgpool::pcp { 'myuser':
#   target        => '/etc/pgpool/pcp.conf',
#   password_hash => 'e2b1fca515949e5d54fb22b8ed95575'
# }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
define pgpool::pcp (
  $ensure        = present,
  $target        = undef,
  $password_hash = undef,
) {
  $target_real = $target ? {
    undef   => $::pgpool::config::pcp_file,
    default => $target
  }

  $ensure_real = $password_hash ? {
    undef   => absent,
    default => $ensure,
  }

  file_line { "${name}-pcp.conf":
    ensure => $ensure_real,
    path   => $target_real,
    line   => "${name}:${password_hash}",
    match  => "^${name}:",
    before => Service['pgpool']
  }
}
