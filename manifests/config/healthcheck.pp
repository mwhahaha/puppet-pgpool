# == Class: pgpool::config::healthcheck
#
# This configures the health check options within the pgpool.conf file.
#
# === Parameters
#
# [*health_check_period*]
# [*health_check_timeout*]
# [*health_check_user*]
# [*health_check_password*]
# [*health_check_max_retries*]
# [*health_check_retry_delay*]
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config::healthcheck':
#   health_check_user     = 'myuser',
#   health_check_password = 'mypassword',
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
class pgpool::config::healthcheck (
  $health_check_period      = 5,
  $health_check_timeout     = 20,
  $health_check_user        = 'pgpool',
  $health_check_password    = '',
  $health_check_max_retries = 0,
  $health_check_retry_delay = 1,
) {

  $healthcheck_config = {
    'health_check_period'          => { value => $health_check_period },
    'health_check_timeout'         => { value => $health_check_timeout },
    'health_check_user'            => { value => $health_check_user },
    'health_check_password'        => { value => $health_check_password },
    'health_check_max_retries'     => { value => $health_check_max_retries },
    'health_check_max_retry_delay' => { value => $health_check_max_retry_delay },
  }

  $healthcheck_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $healthcheck_config, $healthcheck_defaults)
}
