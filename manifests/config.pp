class check_mk_multisite::config {
  file {$check_mk_multisite::sites_config:
    ensure  => present,
    content => template('check_mk_multisite/sites.mk.erb'),
    notify  => Class['check_mk_multisite::service'],
  }

  if $check_mk_multisite::proxy_usage {
    file {$check_mk_multisite::proxy_config:
      ensure  => present,
      content => template('check_mk_multisite/multisite_proxy.conf.erb'),
      notify  => Class['check_mk_multisite::service'],
      require => Exec['enable_mod_proxy'],
    }

    exec{'enable_mod_rewrite':
      path    => '/bin:/usr/sbin:/usr/bin',
      command => 'a2enmod rewrite &>/dev/null',
      onlyif  => 'test ! -e /etc/apache2/mods-enabled/rewrite.load',
    }

    exec{'enable_mod_proxy':
      path    => '/bin:/usr/sbin:/usr/bin',
      command => 'a2enmod proxy_http &>/dev/null',
      onlyif  => 'test ! -e /etc/apache2/mods-enabled/proxy_http.load',
    }
  }

  user {"${name}-www-data":
    ensure  => present,
    name    => 'www-data',
    groups  => nagios,
  }
}

