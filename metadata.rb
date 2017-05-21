name 'winlogbeat_lwrp'
maintainer 'Andrey Aleksandrov'
maintainer_email 'postgred@gmail.com'
license 'MIT'
description 'Installs/Configures winlogbeat_lwrp'
long_description 'Installs/Configures winlogbeat_lwrp'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'windows'
