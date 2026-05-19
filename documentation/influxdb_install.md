# influxdb_install

Installs the InfluxDB 3 Core package.

## Actions

| Action     | Description          |
| ---------- | -------------------- |
| `:install` | Installs the package |
| `:remove`  | Removes the package  |
| `:delete`  | Removes the package  |

## Properties

| Property           | Type        | Default       | Description                            |
| ------------------ | ----------- | ------------- | -------------------------------------- |
| `package_name`     | String      | name property | Package to install                     |
| `version`          | String, nil | `nil`         | Optional package version               |
| `setup_repository` | true, false | `true`        | Whether to manage the repository first |

## Examples

```ruby
influxdb_install 'influxdb3-core'
```

```ruby
influxdb_repository 'influxdata'

influxdb_install 'influxdb3-core' do
  setup_repository false
end
```
