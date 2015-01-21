# == Class: pgpool::config::other
#
# This class configures the other items for pgpool in the pgpool.conf.
#
# === Parameters
#
# [*relcache_expire*]
#   Integer. The life time of the relation cache in seconds.
#   Defaults to <tt>0</tt>.
#
# [*relcache_size*]
#   Intger. The number of relcache entries.
#   Defaults to <tt>256</tt>.
#
# [*check_temp_table*]
#   String. If on, enable temporary table check in SELECT statements. This
#   initiates queries against system catalog of primary/master thus increases
#   load of primary/master. If you are absolutely sure that your system never
#   uses temporary tables and you want to save access to primary/master, you
#   could turn this off.
#   Defaults to <tt>on</tt>.
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
class pgpool::config::other (
  $relcache_expire  = 0,
  $relcache_size    = 256,
  $check_temp_table = 'on',
) {

  $other_config = {
    'relcache_expire'  => { value => $relcache_expire },
    'relcache_size'    => { value => $relcache_size },
    'check_temp_table' => { value => $check_temp_table },
  }

  $other_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $other_config, $other_defaults)
}
