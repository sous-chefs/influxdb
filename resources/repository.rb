# frozen_string_literal: true

require 'shellwords'

provides :influxdb_repository
unified_mode true

property :repo_name, String, name_property: true
property :description, String, default: 'InfluxData Repository - Stable'
property :gpg_key_url, String, default: 'https://repos.influxdata.com/influxdata-archive.key'
property :gpg_key_fingerprint, String, default: '24C975CBA61A024EE1B631787C3D57159FC2F927'
property :apt_uri, String, default: 'https://repos.influxdata.com/debian'
property :apt_distribution, String, default: 'stable'
property :apt_components, Array, default: ['main']
property :apt_keyring, String, default: '/usr/share/keyrings/influxdata-archive.gpg'
property :apt_key_file, String, default: lazy { ::File.join(Chef::Config[:file_cache_path], 'influxdata-archive.key') }
property :yum_baseurl, String, default: 'https://repos.influxdata.com/stable/$basearch/main'
property :yum_keyring_dir, String, default: '/usr/share/influxdata-archive-keyring/keyrings'
property :yum_key_file, String, default: lazy { ::File.join(yum_keyring_dir, 'influxdata-archive.asc') }
property :enabled, [true, false], default: true
property :gpgcheck, [true, false], default: true
property :make_cache, [true, false], default: true

default_action :create

action :create do
  gpg_install 'influxdb repository gpg tooling'

  case node['platform_family']
  when 'debian'
    directory ::File.dirname(new_resource.apt_keyring) do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    remote_file new_resource.apt_key_file do
      source new_resource.gpg_key_url
      owner 'root'
      group 'root'
      mode '0644'
    end

    execute 'verify InfluxData GPG key fingerprint' do
      command "gpg --show-keys --with-fingerprint --with-colons #{shell_escape(new_resource.apt_key_file)} | grep -q '^fpr:\\+#{new_resource.gpg_key_fingerprint}:$'"
      not_if { ::File.exist?(new_resource.apt_keyring) }
    end

    execute 'dearmor InfluxData GPG key' do
      command "gpg --dearmor --yes --output #{shell_escape(new_resource.apt_keyring)} #{shell_escape(new_resource.apt_key_file)}"
      creates new_resource.apt_keyring
    end

    apt_repository new_resource.repo_name do
      uri new_resource.apt_uri
      distribution new_resource.apt_distribution
      components new_resource.apt_components
      signed_by new_resource.apt_keyring
      cache_rebuild true
      action :add
    end
  when 'rhel', 'amazon', 'fedora'
    directory new_resource.yum_keyring_dir do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end

    remote_file new_resource.yum_key_file do
      source new_resource.gpg_key_url
      owner 'root'
      group 'root'
      mode '0644'
    end

    yum_repository new_resource.repo_name do
      description new_resource.description
      baseurl new_resource.yum_baseurl
      enabled new_resource.enabled
      gpgcheck new_resource.gpgcheck
      gpgkey "file://#{new_resource.yum_key_file}"
      make_cache new_resource.make_cache
      action :create
    end
  else
    raise Chef::Exceptions::UnsupportedPlatform, "#{new_resource} supports Debian and RPM platform families only"
  end
end

action_class do
  def shell_escape(value)
    Shellwords.escape(value)
  end
end

action :delete do
  case node['platform_family']
  when 'debian'
    apt_repository new_resource.repo_name do
      action :remove
    end

    file new_resource.apt_keyring do
      action :delete
    end

    file new_resource.apt_key_file do
      action :delete
    end

  when 'rhel', 'amazon', 'fedora'
    yum_repository new_resource.repo_name do
      action :remove
    end

    file new_resource.yum_key_file do
      action :delete
    end
  end
end
