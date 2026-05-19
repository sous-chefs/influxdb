# influxdb_service

Manages the packaged InfluxDB 3 Core service.

## Actions

| Action     | Description             |
|------------|-------------------------|
| `:enable`  | Enables the service     |
| `:disable` | Disables the service    |
| `:start`   | Starts the service      |
| `:stop`    | Stops the service       |
| `:restart` | Restarts the service    |
| `:delete`  | Stops and disables it   |

## Properties

| Property       | Type   | Default       | Description        |
|----------------|--------|---------------|--------------------|
| `service_name` | String | name property | Service name       |

## Examples

```ruby
influxdb_service 'influxdb3-core'
```

```ruby
influxdb_service 'influxdb3-core' do
  action :restart
end
```
