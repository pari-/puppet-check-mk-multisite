class check_mk_multisite::params {
  $ensure = 'present'
  $auto_upgrade = false
  $service_ensure = 'running'
  $service_enable = true
  $sites = { '' => '' }

  $proxy_usage = true

  case $::operatingsystem {
    'Debian': {
      $package = [ 'check-mk-multisite', 'apache2-mpm-prefork' ]
      $config = '/etc/check_mk/multisite.mk'
      $sites_config = '/etc/check_mk/multisite.d/sites.mk'
      $proxy_config = '/etc/apache2/conf.d/multisite_proxy.conf'
      $service_name = 'apache2'
    }
    default: {
      fail("\"${module_name}\" is not supported on \"${::operatingsystem}\"")
    }
  }

}
