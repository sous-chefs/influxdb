# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb_service' do
  step_into :influxdb_service
  platform 'ubuntu', '24.04'

  context 'with default actions' do
    recipe do
      influxdb_service 'influxdb3-core'
    end

    it { is_expected.to enable_service('influxdb3-core') }
    it { is_expected.to start_service('influxdb3-core') }
  end

  context 'restart action' do
    recipe do
      influxdb_service 'influxdb3-core' do
        action :restart
      end
    end

    it { is_expected.to restart_service('influxdb3-core') }
  end

  context 'delete action' do
    recipe do
      influxdb_service 'influxdb3-core' do
        action :delete
      end
    end

    it { is_expected.to stop_service('influxdb3-core') }
    it { is_expected.to disable_service('influxdb3-core') }
  end
end
