provides :winlogbeat_install

property :name, String, default: ''
property :version, String, default: '5.4.0'
property :bit, String, default: 'x86_64'
property :install_path, String, default: "#{ENV['SystemDrive']}/Program Files/Winlogbeat"
property :custom_url, String
property :conf_cookbook, String, default: 'winlogbeat_lwrp'
property :conf_template_source, String, default: 'winlogbeat.yml.erb'

action :create do
  archive_url =
    if custom_url.nil?
      "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-#{version}-windows-#{bit}.zip"
    else
      custom_url
    end
  archive_path = "#{Chef::Config[:file_cache_path]}/winlogbeat-#{version}-#{bit}.zip"
  winlogbeat_dir = "#{install_path}/winlogbeat-#{version}-windows-#{bit}"

  remote_file 'archive' do
    path archive_path
    source archive_url
    action :create_if_missing
  end

  windows_zipfile install_path do
    source archive_path
    action :unzip
    not_if { ::File.exist?(winlogbeat_dir) }
  end

  execute 'create winlogbeat service' do
    cwd winlogbeat_dir
    command 'powershell ./install-service-winlogbeat.ps1'
    not_if { ::Win32::Service.exists?('winlogbeat') }
  end

  service 'winlogbeat' do
    action [:enable, :start]
  end

  template "#{winlogbeat_dir}/winlogbeat.yml" do
    cookbook conf_cookbook
    source conf_template_source
    notifies :restart, 'service[winlogbeat]', :immediately
  end
end

action :delete do
  winlogbeat_dir = "#{install_path}/winlogbeat-#{version}-windows-#{bit}"

  service 'winlogbeat' do
    action [:disable, :stop]
    only_if { ::Win32::Service.exists?('winlogbeat') }
  end

  execute 'remove winlogbeat service' do
    cwd winlogbeat_dir
    command 'powershell ./uninstall-service-winlogbeat.ps1'
    only_if { ::Win32::Service.exists?('winlogbeat') }
  end

  directory winlogbeat_dir do
    recursive true
    action :delete
  end
end
