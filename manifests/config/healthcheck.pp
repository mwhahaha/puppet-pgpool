# == Class: pgpool::config::healthcheck
#
# This configures the health check options within the pgpool.conf file.
#
# === Parameters
#
# [*health_check_period*]
#  Integer. The interval between health checks.
#  Defaults to <tt>5</tt>.
#
# [*health_check_timeout*]
#  Integer. The time to wait on a health check.
#  Defaults to <tt>20</tt>.
#
# [*health_check_user*]
#  String. The postgresql user to run the health check as.
#  Defaults to <tt>nobody</tt>.
#
# [*health_check_password*]
#  String. The postgresql password for the user running the health check.
#  Defaults to <tt></tt>.
#
# [*health_check_max_retries*]
#  Integer. Number of times to retry a failed health check.
#  Defaults to <tt>0</tt>.
#
# [*health_check_retry_delay*]
#  Integer. Time to sleep between health checks.
#  Defaults to <tt>1</tt>.
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
class pgpool::config::healthcheck (
  $health_check_period      = 5,
  $health_check_timeout     = 20,
  $health_check_user        = 'nobody',
  $health_check_password    = '',
  $health_check_max_retries = 0,
  $health_check_retry_delay = 1,
) {

  $healthcheck_config = {
    'health_check_period'      => { value => $health_check_period },
    'health_check_timeout'     => { value => $health_check_timeout },
    'health_check_user'        => { value => $health_check_user },
    'health_check_password'    => { value => $health_check_password },
    'health_check_max_retries' => { value => $health_check_max_retries },
    'health_check_retry_delay' => { value => $health_check_retry_delay },
  }

  $healthcheck_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $healthcheck_config, $healthcheck_defaults)
}
