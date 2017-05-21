
[Build status](https://ci.appveyor.com/api/projects/status/github/postgred/winlogbeat_lwrp?branch=master&svg=true)

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

# Recipes
## default

Installs winlogbeat.

# License & Authors
- Author:: Andrey Aleksandrov (<postgred@gmail.com>)

```text
Copyright 2017 Andrey Aleksandrov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
