# == Class: rocket
#
# Module to install and manage the Rocket command line tools
#
# === Parameters
# [*version*]
#   What version of rkt and actool to install
#
# [*ensure*]
#   Whether to install or uninstall the command line tools
#   Defaults to present, can also be set to absent
#
class rocket(
  $version = $rocket::params::version,
  $ensure = $rocket::params::ensure,
) inherits rocket::params {

  validate_string($version)
  validate_re($ensure, '^(present|absent)$')

  Archive {
    target           => '/usr/local/src',
    checksum         => false,
    follow_redirects => true,
    src_target       => '/usr/local/src',
  }

  archive { "rocket-v${version}":
    ensure => $ensure,
    url    => "https://github.com/coreos/rocket/releases/download/v${version}/rocket-v${version}.tar.gz",
  }

  archive { "appc-spec-v${version}":
    ensure => $ensure,
    url    => "https://github.com/appc/spec/releases/download/v${version}/appc-spec-v${version}.tar.gz",
  }

  if $ensure == 'present' {
    $file_ensure = 'link'
  } else {
    $file_ensure = $ensure
  }

  file { '/usr/local/bin/rkt':
    ensure  => $file_ensure,
    target  => "/usr/local/src/rocket-v${version}/rkt",
    require => Archive["rocket-v${version}"],
  }

  file { '/usr/local/bin/actool':
    ensure  => $file_ensure,
    target  => "/usr/local/src/appc-spec-v${version}/actool",
    require => Archive["appc-spec-v${version}"],
  }

  Class['rocket'] -> Rocket::Image <||>
  Class['rocket'] -> Rocket::Application <||>
  Rocket::Image <||> -> Rocket::Application <||>

}
