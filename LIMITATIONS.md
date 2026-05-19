# Limitations

## Package Availability

This cookbook installs InfluxDB 3 Core from the official InfluxData package repositories.

### APT (Debian/Ubuntu)

* Repository: `https://repos.influxdata.com/debian stable main`
* Package: `influxdb3-core`
* GPG key: `https://repos.influxdata.com/influxdata-archive.key`
* Supported by this cookbook: Ubuntu 22.04 and newer, Debian 12 and newer.
* Kitchen coverage: Ubuntu 24.04 and Debian 12.

### DNF/YUM (RHEL family)

* Repository: `https://repos.influxdata.com/stable/$basearch/main`
* Package: `influxdb3-core`
* GPG key: `https://repos.influxdata.com/influxdata-archive.key`
* Supported by this cookbook: AlmaLinux 8+, Amazon Linux 2023+, CentOS Stream 9+, Fedora, Oracle Linux 8+, Red Hat Enterprise Linux 8+, and Rocky Linux 8+.
* Kitchen coverage: AlmaLinux 9.

### Zypper (SUSE)

* Not supported by this cookbook.
* The InfluxDB 3 Core install guide documents DEB and RPM package flows but not a SUSE-specific zypper repository flow.

## Architecture Limitations

* InfluxDB 3 Core package and artifact documentation lists Linux AMD64 and ARM64 builds.
* Kitchen coverage in this cookbook uses the standard x86_64 Dokken images.

## Source/Compiled Installation

Source builds and tarball installs are out of scope. This cookbook manages vendor package repositories, package installation, configuration, and the packaged service.

## Known Issues

* InfluxDB 3 Core package installs include a systemd unit named `influxdb3-core`.
* The packaged service is not started on install; configure it first, then enable and start it with `influxdb_service`.
* openSUSE Leap 15.6 reached EOL on 2026-04-30 and is not supported.

## Sources

* InfluxDB 3 Core install docs: <https://docs.influxdata.com/influxdb3/core/install/>
* InfluxData Linux repository key guidance: <https://docs.influxdata.com/influxdb/v2/install/>
* Ubuntu lifecycle: <https://endoflife.date/ubuntu>
* Debian lifecycle: <https://endoflife.date/debian>
* AlmaLinux lifecycle: <https://endoflife.date/almalinux>
* Amazon Linux lifecycle: <https://endoflife.date/amazon-linux>
* openSUSE lifecycle: <https://endoflife.date/opensuse>
