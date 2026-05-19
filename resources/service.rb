# frozen_string_literal: true

provides :influxdb_service
unified_mode true

property :service_name, String, name_property: true

default_action [:enable, :start]

action :enable do
  service new_resource.service_name do
    action :enable
  end
end

action :disable do
  service new_resource.service_name do
    action :disable
  end
end

action :start do
  service new_resource.service_name do
    action :start
  end
end

action :stop do
  service new_resource.service_name do
    action :stop
  end
end

action :restart do
  service new_resource.service_name do
    action :restart
  end
end

action :delete do
  service new_resource.service_name do
    action [:stop, :disable]
  end
end
