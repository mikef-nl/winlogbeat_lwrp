title 'Winlogbeat should be installed and configured'

describe directory('C:/Program Files/Winlogbeat') do
  it { should be_exist }
end

describe directory('C:/Program Files/Winlogbeat/winlogbeat-5.4.0-windows-x86_64') do
  it { should exist }
end

describe service('winlogbeat') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('C:/Program Files/Winlogbeat/winlogbeat-5.4.0-windows-x86_64/winlogbeat.yml') do
  it { should exist }
  it { should be_file }
  its('content') { should match /CONFIG FROM TEST RECIPE/ }
end
