# influxdb_repository

Manages the InfluxData package repository for InfluxDB 3 Core. The resource uses the `gpg` cookbook to install GPG tooling, verifies the InfluxData signing key fingerprint, and manages apt or yum repository files.

## Actions

| Action    | Description                                         |
| --------- | --------------------------------------------------- |
| `:create` | Adds the repository and package signing key         |
| `:delete` | Removes the repository and cookbook-owned key files |

## Properties

| Property              | Type        | Default                                                  | Description                           |
| --------------------- | ----------- | -------------------------------------------------------- | ------------------------------------- |
| `repo_name`           | String      | name property                                            | Repository name                       |
| `description`         | String      | `'InfluxData Repository - Stable'`                       | Yum repository description            |
| `gpg_key_url`         | String      | `'https://repos.influxdata.com/influxdata-archive.key'`  | InfluxData signing key URL            |
| `gpg_key_fingerprint` | String      | `'24C975CBA61A024EE1B631787C3D57159FC2F927'`             | Expected key fingerprint              |
| `apt_uri`             | String      | `'https://repos.influxdata.com/debian'`                  | Apt repository URI                    |
| `apt_distribution`    | String      | `'stable'`                                               | Apt distribution                      |
| `apt_components`      | Array       | `['main']`                                               | Apt components                        |
| `apt_keyring`         | String      | `'/usr/share/keyrings/influxdata-archive.gpg'`           | Apt signed-by keyring path            |
| `yum_baseurl`         | String      | `'https://repos.influxdata.com/stable/$basearch/main'`   | Yum repository base URL               |
| `yum_keyring_dir`     | String      | `'/usr/share/influxdata-archive-keyring/keyrings'`       | Yum key directory                     |
| `yum_key_file`        | String      | `'<yum_keyring_dir>/influxdata-archive.asc'`             | Yum GPG key path                      |
| `enabled`             | true, false | `true`                                                   | Whether the yum repository is enabled |
| `gpgcheck`            | true, false | `true`                                                   | Whether yum GPG checks are enabled    |
| `make_cache`          | true, false | `true`                                                   | Whether yum cache should be built     |

## Examples

```ruby
influxdb_repository 'influxdata'
```

```ruby
influxdb_repository 'internal-influxdata' do
  apt_uri 'https://mirror.example.com/influxdata/debian'
  yum_baseurl 'https://mirror.example.com/influxdata/stable/$basearch/main'
end
```
