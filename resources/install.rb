provides :winlogbeat_install
unified_mode true

property :name, String, default: ''
property :version, String, default: '5.4.0'
property :bit, String, default: 'x86_64'
property :install_path, String, default: "#{ENV['SystemDrive']}/Program Files/Winlogbeat"
property :custom_url, String
property :conf_cookbook, String, default: 'winlogbeat_lwrp'
property :conf_template_source, String, default: 'winlogbeat.yml.erb'

action :create do
    if defined?(custom_url)
      archive_url = custom_url
    else
      archive_url = "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-#{new_resource.version}-windows-#{new_resource.bit}.zip"
    end
  archive_path = "#{Chef::Config[:file_cache_path]}/winlogbeat-#{new_resource.version}-#{new_resource.bit}.zip"
  winlogbeat_dir = "#{new_resource.install_path}\\winlogbeat-#{new_resource.version}-windows-#{new_resource.bit}"

  remote_file 'archive' do
    path archive_path
    source archive_url
    action :create_if_missing
  end

  archive_file new_resource.install_path do
    path archive_path
    destination new_resource.install_path
    not_if { ::File.exist?(winlogbeat_dir) }
  end

  powershell_script 'Install Winlogbeat Service' do
    code "./install-service-winlogbeat.ps1"
    cwd winlogbeat_dir
    not_if { ::Win32::Service.exists?('winlogbeat') }
   end

  service 'winlogbeat' do
    action [:enable, :start]
  end

  template "#{winlogbeat_dir}\\winlogbeat.yml" do
    cookbook new_resource.conf_cookbook
    source new_resource.conf_template_source
    notifies :restart, 'service[winlogbeat]', :immediately
  end
end

action :delete do
  winlogbeat_dir = "#{new_resource.install_path}\\winlogbeat-#{new_resource.version}-windows-#{new_resource.bit}"

  service 'winlogbeat' do
    action [:disable, :stop]
    only_if { ::Win32::Service.exists?('winlogbeat') }
  end

  execute 'remove winlogbeat service' do
    cwd winlogbeat_dir
    command 'powershell ./uninstall-service-winlogbeat.ps1'
    only_if { ::Win32::Service.exists?('winlogbeat') }
  end

  powershell_script 'Uninstall Winlogbeat Service' do
    code "./uninstall-service-winlogbeat.ps1"
    cwd winlogbeat_dir
    only_if { ::Win32::Service.exists?('winlogbeat') }
  end

  directory winlogbeat_dir do
    recursive true
    action :delete
  end
end
