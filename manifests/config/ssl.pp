# == Class: pgpool::config::ssl
#
# This class exposes the ssl settings for pgpool.
#
# === Parameters
#
# [*ssl*]
#   String. Enabling this enables ssl mode for pgpool.
#   Defaults to <tt>off</tt>.
#
# [*ssl_key*]
#   String. This is the path to the ssl key for the certificate to use.
#   Defaults to <tt></tt>.
#
# [*ssl_cert*]
#   String. This is the path to the ssl cert file for the certificate to use.
#   Defaults to <tt></tt>.
#
# [*ssl_ca_cert*]
#   String. This is the path to the ssl ca cert for ssl.
#   Defaults to <tt></tt>.
#
# [*ssl_ca_cert_dir*]
#   String. This is the path to the ssl ca certs for ssl.
#   Defaults to <tt></tt>.
#
# === Variables
#
# N/A
#
# === Examples
#
# class { 'pgpool::config:ssl':
#   ssl         => 'on',
#   ssl_key     => '/etc/pki/tls/private/mykey.pem',
#   ssl_cert    => '/etc/pki/tls/certs/mycert.pem',
#   ssl_ca_cert => '/etc/pki/tls/CA/myca.pem',
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
class pgpool::config::ssl (
  $ssl                    = 'off',
  $ssl_key                = '',
  $ssl_cert               = '',
  $ssl_ca_cert            = '',
  $ssl_ca_cert_dir        = '',
) {

  $ssl_config = {
    'ssl'                    => { value => $ssl },
    'ssl_key'                => { value => $ssl_key },
    'ssl_cert'               => { value => $ssl_cert },
    'ssl_ca_cert'            => { value => $ssl_ca_cert },
    'ssl_ca_cert_dir'        => { value => $ssl_ca_cert_dir },
  }

  $ssl_defaults = {
    ensure => present
  }

  create_resource(pgpool::config::val, $ssl_config, $ssl_defaults)
}
