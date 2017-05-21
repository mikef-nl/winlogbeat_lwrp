# winlogbeat_lwrp cookbook
[winlogbeat](https://www.elastic.co/products/beats/winlogbeat) is a lightweight shipper for Windows Event Logs. This cookbook provide LWRP for installing the shipper.

# Requirements
## Platforms
- Windows

## Chef
- Chef >= 12

## Cookbooks
- windows

# Resource/Provider
## winlogbeat_install
Install winlogbeat to the specified destination directory and overwrite a config by template.

#### Actions
- `:create` - Install winlogbeat and configure
- `:delete` - Delete winlogbeat

#### Attribute Parameters
- `version` - Version of winlogbeat. Default is 5.4.0.
- `bit` - Architecture of Windows(x86_64/x86). Default is x86_64.
- `install_path` - The directory path to install winlogbeat.
- `custom_url` - Url for downloading an archive of winlogbeat.
- `conf_cookbook` - A cookbook with configuration templates.
- `conf_template_source` - Name of an erb template for winlogbeat.yml

#### Examples
Install winlogbeat `5.4.0` in a wrapper.

* Create wrapper(logs-wrapper)
* Add template for winlogbeat.yml
* Use winlogbeat_install in recipe

```ruby
winlogbeat_install '' do
  version '5.4.0'
  conf_cookbook 'logs-wrapper'
  conf_template 'winlogbeat.yml.erb'
end
```
