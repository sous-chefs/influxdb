# influxdb_config

Manages the InfluxDB 3 Core TOML configuration file.

## Actions

| Action    | Description                   |
|-----------|-------------------------------|
| `:create` | Creates the configuration file |
| `:delete` | Deletes the configuration file |

## Properties

| Property       | Type        | Default                                  | Description                       |
|----------------|-------------|------------------------------------------|-----------------------------------|
| `config_path`  | String      | `'/etc/influxdb3/influxdb3-core.conf'`   | Configuration file path           |
| `object_store` | String      | `'file'`                                 | InfluxDB object store             |
| `data_dir`     | String      | `'/var/lib/influxdb3/data'`              | Data directory                    |
| `plugin_dir`   | String      | `'/var/lib/influxdb3/plugins'`           | Plugin directory                  |
| `node_id`      | String      | `'primary-node'`                         | Node identifier                   |
| `settings`     | Hash        | `{}`                                     | Additional top-level TOML settings |
| `owner`        | String      | `'root'`                                 | File owner                        |
| `group`        | String      | `'root'`                                 | File group                        |
| `mode`         | String      | `'0644'`                                 | File mode                         |

## Examples

```ruby
influxdb_config 'default'
```

```ruby
influxdb_config 'default' do
  node_id 'node-a'
  settings(
    'http-bind' => '0.0.0.0:8181',
    'disable-telemetry' => true
  )
end
```

