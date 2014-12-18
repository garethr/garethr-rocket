This Puppet module installs and manages the
[Rocket](https://github.com/coreos/rocket) container runtime.

[![Puppet
Forge](http://img.shields.io/puppetforge/v/garethr/rocket.svg)](https://forge.puppetlabs.com/garethr/rocket)
[![Build
Status](https://secure.travis-ci.org/garethr/garethr-rocket.png)](http://travis-ci.org/garethr/garethr-rocket)

## Usage

To install the Rocket command line utilties `rkt` and `actool` use:

```puppet
include rocket
```

By default this installs the version of Rocket recorded in the `params`
class. You can override this with:

```puppet
class { 'rocket':
  version => '0.1.0',
}
```

Once installed you can use the following two defined types to build
images and run an application under Rocket.

```puppet
rocket::image { 'hello.aci':
  source     => '/vagrant/hello',
  output_dir => '/vagrant',
}

rocket::application { 'hello':
  image => '/vagrant/hello.aci',
}
```

## Limitations

This module currently only supports anything running Upstart, which
probably means Ubuntu.

