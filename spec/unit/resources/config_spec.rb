# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb_config' do
  step_into :influxdb_config
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      influxdb_config 'default'
    end

    it { is_expected.to create_directory('/etc/influxdb3') }

    it do
      is_expected.to create_file('/etc/influxdb3/influxdb3-core.conf').with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('object-store = "file"') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('data-dir = "/var/lib/influxdb3/data"') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('plugin-dir = "/var/lib/influxdb3/plugins"') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('node-id = "primary-node"') }
  end

  context 'with additional settings' do
    recipe do
      influxdb_config 'default' do
        node_id 'node-a'
        settings(
          'http-bind' => '0.0.0.0:8181',
          'num-threads' => 4,
          'disable-telemetry' => true,
          'allowed-origins' => ['https://example.com']
        )
      end
    end

    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('node-id = "node-a"') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('http-bind = "0.0.0.0:8181"') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('num-threads = 4') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('disable-telemetry = true') }
    it { is_expected.to render_file('/etc/influxdb3/influxdb3-core.conf').with_content('allowed-origins = ["https://example.com"]') }
  end

  context 'delete action' do
    recipe do
      influxdb_config 'default' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/influxdb3/influxdb3-core.conf') }
  end
end
