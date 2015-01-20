# pgpool

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with pgpool](#setup)
    * [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module.](#development)

## Overview

This module can be used to manage the installation and configuration of pgpool.

## Module Description

The module leverages augeas to manage the configuration file for pgpool.
Additionally it allows you to manage the pool hba configuration file via the
augeas pg_hba provider.  You can also manage the pool_password file with the
pool password resource provided by the module.  The module does not manage
the installation of the pgdg repository for installation of the latest version
of pgpool.  You can provide the package name to the pgpool module if you have
built your own or would like to leverage a version that is shipped with your
OS.

## Setup

### Setup Requirements **OPTIONAL**

As part of using this module, you will need to have the following modules
installed.

 * camptocamp/augeas
 * puppetlabs/stdlib
 * herculesteam/augeasproviders_core
 * herculesteam/augeasproviders_postgresql


## Usage

Here is a sample configuration for a streaming replica master/slave setup and
pgpool on the same node as the application.
```
# install the package and the service
class { 'pgpool': }

# setup our pgpool.conf
class { 'pgpool::config::connection': }
class { 'pgpool::config::healthcheck':
  health_check_period      => 5,
  health_check_timeout     => 10,
  health_check_user        => 'pgpool',
  health_check_password    => 'mypassword',
  health_check_max_retries => 1,
}
class { 'pgpool::config::loadbalance':
  load_balance_mode => 'on',
}
class { 'pgpool::config::logs':
  log_connections  => 'on',
  log_statement    => 'on',
  log_min_messages => 'info',
}
class { 'pgpool::config::masterslave':
  master_slave_mode     => 'on',
  master_slave_sub_mode => 'stream',
  sr_check_period       => 5,
  sr_check_user         => 'pgpool',
  sr_check_password     => 'mypassword',
  delay_threshold       => 1024000,
}
class { 'pgpool::config::pools':
  enable_pool_hba => 'on',
}
class { 'pgpool::config::replication':
  replication_mode => 'off',
}
class { 'pgpool::config::service':
  pid_file_name => '/var/run/pgpool-II-93/pgpool-II-93.pid',
  logdir        => '/tmp',
}
class { 'pgpool::config::ssl': }
class { 'pgpool::config::watchdog': }

# configure our backend systems
pgpool::config::backend { 'db-n01':
  id             => '0',
  hostname       => '10.0.0.4',
  port           => 5432,
  data_directory => '/var/lib/pgsql/9.3/data',
}
pgpool::config::backend { 'db-n02':
  id             => '1',
  hostname       => '10.0.0.5',
  port           => 5432,
  data_directory => '/var/lib/pgsql/9.3/data',
}

# configure our application user password access
pgpool::pool_passwd { 'my_app_user':
  password_hash => 'md5d6d70ecf643d4sec9ca6623fee1233ea',
}

# configure the pgpool hba configuration
pgpool::hba { 'my_app_user':
  type     => 'host',
  database => 'my_db_name',
  user     => 'my_app_user',
  address  => '127.0.0.1/32',
  method   => 'md5',
}
```

## Reference

Here is a list of all the available classes and resources for this module.

Classes:

 * pgpool
 * pgpool::config
 * pgpool::service
 * pgpool::package
 * pgpool::config::watchdog
 * pgpool::config::pools
 * pgpool::config::loadbalance
 * pgpool::config::healthcheck
 * pgpool::config::other
 * pgpool::config::memorycache
 * pgpool::config::ssl
 * pgpool::config::logs
 * pgpool::config::replication
 * pgpool::config::masterslave
 * pgpool::config::connection
 * pgpool::config::heartbeat
 * pgpool::config::service
 * pgpool::config::failover

Resources:

 * pgpool::pool_passwd
 * pgpool::pcp
 * pgpool::hba
 * pgpool::config::backend
 * pgpool::config::val
 * pgpool::config::wdother

## Limitations

This has only been tested on RedHat/CentOS 6.

## Development

Pull requests welcome.
