# frozen_string_literal: true

require 'spec_helper'

describe 'influxdb_repository' do
  step_into :influxdb_repository

  context 'on Ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      influxdb_repository 'influxdata'
    end

    it { is_expected.to install_gpg_install('influxdb repository gpg tooling') }
    it { is_expected.to create_directory('/usr/share/keyrings') }

    it do
      is_expected.to create_remote_file(File.join(Chef::Config[:file_cache_path], 'influxdata-archive.key'))
        .with(source: 'https://repos.influxdata.com/influxdata-archive.key')
    end

    it { is_expected.to run_execute('verify InfluxData GPG key fingerprint') }
    it { is_expected.to run_execute('dearmor InfluxData GPG key') }

    it do
      is_expected.to add_apt_repository('influxdata').with(
        uri: 'https://repos.influxdata.com/debian',
        distribution: 'stable',
        components: ['main'],
        signed_by: '/usr/share/keyrings/influxdata-archive.gpg'
      )
    end
  end

  context 'on AlmaLinux' do
    platform 'almalinux', '9'

    recipe do
      influxdb_repository 'influxdata'
    end

    it { is_expected.to install_gpg_install('influxdb repository gpg tooling') }
    it { is_expected.to create_directory('/usr/share/influxdata-archive-keyring/keyrings') }

    it do
      is_expected.to create_remote_file('/usr/share/influxdata-archive-keyring/keyrings/influxdata-archive.asc')
        .with(source: 'https://repos.influxdata.com/influxdata-archive.key')
    end

    it do
      is_expected.to create_yum_repository('influxdata').with(
        description: 'InfluxData Repository - Stable',
        baseurl: 'https://repos.influxdata.com/stable/$basearch/main',
        gpgkey: 'file:///usr/share/influxdata-archive-keyring/keyrings/influxdata-archive.asc'
      )
    end
  end

  context 'delete action on Ubuntu' do
    platform 'ubuntu', '24.04'

    recipe do
      influxdb_repository 'influxdata' do
        action :delete
      end
    end

    it { is_expected.to remove_apt_repository('influxdata') }
    it { is_expected.to delete_file('/usr/share/keyrings/influxdata-archive.gpg') }
    it { is_expected.to delete_file(File.join(Chef::Config[:file_cache_path], 'influxdata-archive.key')) }
  end

  context 'delete action on AlmaLinux' do
    platform 'almalinux', '9'

    recipe do
      influxdb_repository 'influxdata' do
        action :delete
      end
    end

    it { is_expected.to remove_yum_repository('influxdata') }
    it { is_expected.to delete_file('/usr/share/influxdata-archive-keyring/keyrings/influxdata-archive.asc') }
  end
end
