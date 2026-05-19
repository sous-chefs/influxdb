# frozen_string_literal: true

provides :influxdb_install
unified_mode true

property :package_name, String, name_property: true
property :version, [String, nil]
property :setup_repository, [true, false], default: true

default_action :install

action :install do
  influxdb_repository 'influxdata' if new_resource.setup_repository

  package new_resource.package_name do
    version new_resource.version if new_resource.version
    action :install
  end
end

action :remove do
  package new_resource.package_name do
    action :remove
  end
end

action :delete do
  package new_resource.package_name do
    action :remove
  end
end
