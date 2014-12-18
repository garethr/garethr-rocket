# == Type: rocket::application
#
# Defined type to manage a running rocket container
#
# === Parameters
# [*image*]
#   The name of the image to run
#
# [*running*]
#   Whether or not the service should be running.
#   Defaults to true.
#
define rocket::application(
  $image = undef,
  $running = true,
) {

  validate_string($image)
  validate_bool($running)

  $sanitised_title = regsubst($title, '[^0-9A-Za-z.\-]', '-', 'G')
  $initscript = "/etc/init/rocket-${sanitised_title}.conf"

  file { $initscript:
    ensure  => present,
    content => template('rocket/etc/init/application.conf.erb'),
  }

  service { "rocket-${sanitised_title}":
    ensure     => $running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    provider   => 'upstart',
    require    => File[$initscript],
  }
}
