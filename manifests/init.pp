class check_mk_multisite (
  $ensure         = $check_mk_multisite::params::ensure,
  $package        = $check_mk_multisite::params::package,
  $auto_upgrade   = $check_mk_multisite::params::auto_upgrade,
  $config         = $check_mk_multisite::params::config,
  $sites_config   = $check_mk_multisite::params::sites_config,
  $sites          = $check_mk_multisite::params::sites,
  $proxy_config   = $check_mk_multisite::params::proxy_config,
  $service_name   = $check_mk_multisite::params::service_name,
  $service_ensure = $check_mk_multisite::params::service_ensure,
  $service_enable = $check_mk_multisite::params::service_enable,
  $proxy_usage    = $check_mk_multisite::params::proxy_usage
) inherits check_mk_multisite::params {

  class {'check_mk_multisite::package':}
  class {'check_mk_multisite::config':}
  class {'check_mk_multisite::service':}

  if $ensure == 'present' {
    Class['check_mk_multisite::package'] -> Class['check_mk_multisite::config'] ~> Class['check_mk_multisite::service']
  } else {
    Class['check_mk_multisite::service'] -> Class['check_mk_multisite::package']
  }
}
