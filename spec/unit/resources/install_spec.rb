# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb_install' do
  step_into :influxdb_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      influxdb_install 'influxdb3-core'
    end

    it { is_expected.to create_influxdb_repository('influxdata') }
    it { is_expected.to install_package('influxdb3-core') }
  end

  context 'with repository setup disabled' do
    recipe do
      influxdb_install 'influxdb3-core' do
        setup_repository false
      end
    end

    it { is_expected.not_to create_influxdb_repository('influxdata') }
    it { is_expected.to install_package('influxdb3-core') }
  end

  context 'with a pinned package version' do
    recipe do
      influxdb_install 'influxdb3-core' do
        version '3.0.0'
      end
    end

    it { is_expected.to install_package('influxdb3-core').with(version: '3.0.0') }
  end

  context 'remove action' do
    recipe do
      influxdb_install 'influxdb3-core' do
        action :remove
      end
    end

    it { is_expected.to remove_package('influxdb3-core') }
  end
end
