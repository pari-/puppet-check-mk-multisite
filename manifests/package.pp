class check_mk_multisite::package {
  if $check_mk_multisite::ensure == 'present' {
    $package_ensure = $check_mk_multisite::auto_upgrade ? {
      true  => 'latest',
      false => 'installed',
    }
  } else {
    $package_ensure = 'purged'
  }

  $multisite_d_ensure = $package_ensure ? {
    'latest'    => 'directory',
    'installed' => 'directory',
    'purged'    => 'absent',
  }

  file {'/etc/check_mk/multisite.d':
    ensure  => $multisite_d_ensure,
    force   => false,
    recurse => false,
    require => Package[$check_mk_multisite::package],
    notify  => Class['check_mk_multisite::service'],
  }

  package {$check_mk_multisite::package:
    ensure          => $package_ensure,
    provider        => 'aptbpo',
    install_options => { '-t' => 'squeeze-backports' },
  }

}
