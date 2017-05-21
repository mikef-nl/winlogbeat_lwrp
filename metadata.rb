name             'winlogbeat_lwrp'
maintainer       'Andrey Aleksandrov'
maintainer_email 'postgred@gmail.com'
license          'MIT'
description      'LWRP for winlogbeat(shipper for Elasticsearch & Logstash)'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/postgred/winlogbeat_lwrp'
issues_url       'https://github.com/postgred/winlogbeat_lwrp/issues'
supports         'windows'
version          '1.0.0'

depends          'windows'

chef_version     '>= 12.1' if respond_to?(:chef_version)
