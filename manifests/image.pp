# == Type: rocket::image
#
# Build a rocket image from a directory, including a manifest
#
# === Parameters
# [*source*]
#   The directory from which to build the image
#
# [*output_dir*]
#   The folder to output the .aci file to
#
define rocket::image(
  $source = undef,
  $output_dir = undef,
) {

  validate_string($source)
  validate_string($output_dir)

  $output = "${output_dir}/${name}"
  $command = "actool build ${source} ${output}"
  exec { $command:
    path    => ['/usr/local/bin'],
    creates => $output
  }
}
