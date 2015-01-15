# == Class: pgpool::config::memorycache
#
# This class configures the memory caching options in pgpool.
#
# === Parameters
#
# [*memory_cache_enabled*]
#   String. Enable the memory cache functionality.
#   Defaults to <tt>off</tt>.
#
# [*memqcache_method*]
#   String. The method of caching storage. Should be either <tt>shmem</tt> or
#   <tt>memcached</tt>.
#   Defaults to <tt>shmem</tt>.
#
# [*memqcache_memcached_host*]
#   String. The memcache host to use.
#   Defaults to <tt>localhost</tt>.
#
# [*memqcache_memcached_port*]
#   Integer. The memcache port to use.
#   Defaults to <tt>11211</tt>.
#
# [*memqcache_total_size*]
#   Integer. The total size of the memory cache.
#   Defaults to <tt>67108864</tt>.
#
# [*memqcache_max_num_cache*]
#   Integer. The total number of items to cache.
#   Defaults to <tt>1000000</tt>.
#
# [*memqcache_expire*]
#   Intger. The expire time in seconds.
#   Defaults to <tt>0</tt>.
#
# [*memqcache_auto_cache_invalidation*]
#   String. Should the cache be invalidated automatically.
#   Defaults to <tt>on</tt>.
#
# [*memqcache_maxcache*]
#   Integer. The maxium size of a SELECT result to cache.
#   Defaults to <tt>409600</tt>.
#
# [*memqcache_cache_block_size*]
#   Intger. If cache storage is shared memory, pgpool uses the memory divided
#   by memqcache_cache_block_size. SELECT result is packed into the block.
#   However because the SELECT result cannot be placed in several blocks, it
#   cannot be cached if it is larger than memqcache_cache_block_size.
#   memqcache_cache_block_size must be greater or equal to 512.
#   Defaults to <tt>1048576</tt>.
#
# [*memqcache_oiddir*]
#   String. The full path to the directory where the oids of tables used by
#   SELECTs are stored.
#   Defaults to <tt>/var/log/pgpool/oiddir</tt>.
#
# [*white_memqcache_table_list*]
#   String. Comma separated lsit of tables names who select results are to be
#   cached.
#   Defaults to <tt>''</tt>.
#
# [*black_memqcache_table_list*]
#   String. Comma separated lsit of tables names who select results are NOT to
#   be cached.
#   Defaults to <tt>''</tt>.
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
# === Copyright
#
# Copyright 2015 Alex Schultz, unless otherwise noted.
#
class pgpool::config::memorycache (
  $memory_cache_enabled              = 'off',
  $memqcache_method                  = 'shmem',
  $memqcache_memcached_host          = 'localhost',
  $memqcache_memcached_port          = 11211,
  $memqcache_total_size              = 67108864,
  $memqcache_max_num_cache           = 1000000,
  $memqcache_expire                  = 0,
  $memqcache_auto_cache_invalidation = 'on',
  $memqcache_maxcache                = 409600,
  $memqcache_cache_block_size        = 1048576,
  $memqcache_oiddir                  = '/var/log/pgpool/oiddir',
  $white_memqcache_table_list        = '',
  $black_memqcache_table_list        = '',
) {

  $memorycache_config = {
    'memory_cache_enabled'              => { value => $memory_cache_enabled },
    'memqcache_method'                  => { value => $memqcache_method },
    'memqcache_memcached_host'          => { value => $memqcache_memcached_host },
    'memqcache_memcached_port'          => { value => $memqcache_memcached_port },
    'memqcache_total_size'              => { value => $memqcache_total_size },
    'memqcache_max_num_cache'           => { value => $memqcache_max_num_cache },
    'memqcache_expire'                  => { value => $memqcache_expire },
    'memqcache_auto_cache_invalidation' => { value => $memqcache_auto_cache_invalidation },
    'memqcache_max_cache'               => { value => $memqcache_max_cache },
    'memqcache_cache_block_size'        => { value => $memqcache_cache_block_size },
    'memqcache_oiddir'                  => { value => $memqcache_oiddir },
    'white_memqcache_table_list'        => { value => $white_memqcache_table_list },
    'black_memqcache_table_list'        => { value => $black_memqcache_table_list },
  }

  $memorycache_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $memorycache_config, $memorycache_defaults)
}
