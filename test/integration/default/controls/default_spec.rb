# frozen_string_literal: true

title 'InfluxDB 3 Core default installation'

control 'influxdb-package-01' do
  impact 1.0
  title 'InfluxDB 3 Core package is installed'

  describe package('influxdb3-core') do
    it { should be_installed }
  end
end

control 'influxdb-config-01' do
  impact 1.0
  title 'InfluxDB 3 Core config file is managed'

  describe file('/etc/influxdb3/influxdb3-core.conf') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should include 'object-store = "file"' }
    its('content') { should include 'data-dir = "/var/lib/influxdb3/data"' }
    its('content') { should include 'plugin-dir = "/var/lib/influxdb3/plugins"' }
    its('content') { should include 'node-id = "primary-node"' }
  end
end

control 'influxdb-service-01' do
  impact 1.0
  title 'InfluxDB 3 Core service is enabled and running'

  describe systemd_service('influxdb3-core') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'influxdb-cli-01' do
  impact 0.7
  title 'InfluxDB 3 Core CLI is available'

  describe command('/usr/bin/influxdb3 --version') do
    its('exit_status') { should eq 0 }
  end
end
