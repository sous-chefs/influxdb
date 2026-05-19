# frozen_string_literal: true

influxdb_repository 'influxdata'

influxdb_install 'influxdb3-core' do
  setup_repository false
end

influxdb_config 'default'

influxdb_service 'influxdb3-core'
