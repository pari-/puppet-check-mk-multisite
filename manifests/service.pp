class check_mk_multisite::service {
  service {$check_mk_multisite::service_name:
    ensure     => $check_mk_multisite::service_ensure,
    enable     => $check_mk_multisite::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
