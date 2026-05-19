# Migration Guide

## Full custom resource migration

This cookbook no longer provides `influxdb::default`. Consumers should declare the custom resources they need directly.

Before:

```ruby
include_recipe 'influxdb::default'
```

After:

```ruby
influxdb_repository 'influxdata'

influxdb_install 'influxdb3-core' do
  setup_repository false
end

influxdb_config 'default'

influxdb_service 'influxdb3-core'
```

## Product target

The cookbook now manages InfluxDB 3 Core. It does not install or configure InfluxDB OSS v1 or v2.

## Configuration

Use `influxdb_config` properties instead of node attributes. Additional supported InfluxDB top-level settings can be passed with the `settings` hash.

```ruby
influxdb_config 'default' do
  node_id 'primary-node'
  settings(
    'http-bind' => '0.0.0.0:8181',
    'disable-telemetry' => true
  )
end
```
