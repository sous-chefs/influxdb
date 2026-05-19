# influxdb

Provides custom resources for installing and configuring InfluxDB 3 Core.

## Resources

* [`influxdb_repository`](documentation/influxdb_repository.md)
* [`influxdb_install`](documentation/influxdb_install.md)
* [`influxdb_config`](documentation/influxdb_config.md)
* [`influxdb_service`](documentation/influxdb_service.md)

## Example

```ruby
influxdb_repository 'influxdata'

influxdb_install 'influxdb3-core' do
  setup_repository false
end

influxdb_config 'default'

influxdb_service 'influxdb3-core'
```

## Migration

See [migration.md](migration.md) for the breaking change from the legacy recipe entrypoint to custom resources.
