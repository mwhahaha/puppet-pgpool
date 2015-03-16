# == Type: pgpool::config::heartbeat
#
# This resource configures the heartbeat backends configuration items within
# the pgpool.conf file.
#
# === Parameters
#
# [*ensure*]
#   String. This controls if this heartbeat destination should be int he config
#   Defaults to <tt>present</tt>.
#
# [*id*]
#   Integer. This is the id for the heartbeat destintation. It needs to be
#   unique for each entry.
#   Defaults to <tt>0</tt>.
#
# [*destination*]
#   String. This is ip or hostname for the heartbeat destination.
#   Defaults to <tt>localhost</tt>.
#
# [*port*]
#   Integer. This is the port for the heartbeat destination.
#   Defaults to <tt>5555</tt>.
#
# [*device*]
#   String. This is the network device name for sending heartbeat signals.
#   Defaults to <tt>''</tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
# pgpool::config::heartbeat { 'host1':
#   id          => 0,
#   destination => 'host1.example.com',
#   port        => 5556,
#   device      => 'eth0'
# }
#
# === Authors
#
# Alex Schultz <aschultz@next-development.com>
#
define pgpool::config::heartbeat (
  $ensure         = present,
  $id             = 0,
  $destination    = 'localhost',
  $port           = 5555,
  $device         = '',
) {

  $heartbeat_config = {
    "heartbeat_destination${id}" => { value => $destination },
    "heartbeat_port${id}"        => { value => $port },
    "heartbeat_device${id}"      => { value => $device},
  }

  $heartbeat_defaults = {
    ensure => $ensure
  }

  create_resources(pgpool::config::val, $heartbeat_config, $heartbeat_defaults)
}
