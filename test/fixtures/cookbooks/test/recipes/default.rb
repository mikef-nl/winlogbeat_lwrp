winlogbeat_install '' do
  version '5.4.0'
  bit 'x86_64'
  conf_cookbook 'test'
  conf_template_source 'config.yml.erb'
end
