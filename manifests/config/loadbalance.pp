# == Class: pgpool::config::loadbalance
#
# This class allows for the configuration of the loadbalancer options within
# the pgpool.conf file.
#
# === Parameters
#
# [*load_balance_mode*]
#   String. Should SELECT queries will be distributed to each backend for load
#   balancing.
#   Defaults to <tt>off</tt>.
#
# [*ignore_leading_white_space*]
#   String. Ignore leading spaces at the start of the query in load balancer
#   mode.
#   Defaults to <tt>on</tt>.
#
# [*white_function_list*]
#   String. Comma seperate list of function names that do NOT update the DB.
#   Defaults to <tt>''</tt>.
#
# [*black_function_list*]
#   String. Comma seperate list of function names that update the DB.
#   Defaults to <tt>''</tt>.
# 
# [*app_name_redirect_preference_list*]
#   Specifies the list of "application-name:node id(ratio)" pairs to send SELECT 
#   queries to a particular backend node for a particular client application connection 
#   at a specified load balance ratio. 
#   Defaults to <tt>''</tt>
#
# [*database_redirect_preference_list*]
#   Specifies the list of "database-name:node id(ratio)" pairs to send SELECT queries 
#   to a particular backend node for a particular database connection at a specified 
#   load balance ratio. The load balance ratio specifies a value between 0 and 1. The 
#   default is 1.0.
#   Defaults to <tt>''</tt>
#
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config::loadbalance':
#   load_balance_mode => 'on',
# }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
class pgpool::config::loadbalance (
  $load_balance_mode                  = 'off',
  $ignore_leading_white_space         = 'on',
  $white_function_list                = '',
  $black_function_list                = 'currval,lastval,nextval,setval',
  $app_name_redirect_preference_list  = '',
  $database_redirect_preference_list  = '',
) {

  $loadbalance_config = {
    'load_balance_mode'                 => { value => $load_balance_mode },
    'ignore_leading_white_space'        => { value => $ignore_leading_white_space },
    'white_function_list'               => { value => $white_function_list },
    'black_function_list'               => { value => $black_function_list },
    'app_name_redirect_preference_list' => {value => $app_name_redirect_preference_list },
    'database_redirect_preference_list' => {value => $database_redirect_preference_list },
  }

  $loadbalance_defaults = {
    ensure => present
  }

  create_resources(pgpool::config::val, $loadbalance_config, $loadbalance_defaults)
}
