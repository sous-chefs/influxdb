# frozen_string_literal: true

provides :influxdb_config
unified_mode true

property :config_path, String, default: '/etc/influxdb3/influxdb3-core.conf'
property :object_store, String, default: 'file'
property :data_dir, String, default: '/var/lib/influxdb3/data'
property :plugin_dir, String, default: '/var/lib/influxdb3/plugins'
property :node_id, String, default: 'primary-node'
property :settings, Hash, default: {}
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :mode, String, default: '0644'

default_action :create

action :create do
  validate_settings!

  directory ::File.dirname(new_resource.config_path) do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
    recursive true
  end

  file new_resource.config_path do
    content config_content
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end
end

action :delete do
  file new_resource.config_path do
    action :delete
  end
end

action_class do
  RESERVED_SETTINGS = %w(object-store data-dir plugin-dir node-id).freeze

  def config_content
    lines = [
      '# Managed by Chef. Local changes will be overwritten.',
      setting_line('object-store', new_resource.object_store),
      setting_line('data-dir', new_resource.data_dir),
      setting_line('plugin-dir', new_resource.plugin_dir),
      setting_line('node-id', new_resource.node_id),
    ]

    new_resource.settings.sort.each do |key, value|
      lines << setting_line(key.to_s, value)
    end

    "#{lines.join("\n")}\n"
  end

  def setting_line(key, value)
    "#{key} = #{toml_value(value)}"
  end

  def toml_value(value)
    case value
    when String
      value.dump
    when Integer, Float
      value.to_s
    when true, false
      value.to_s
    when Array
      "[#{value.map { |item| toml_value(item) }.join(', ')}]"
    else
      raise Chef::Exceptions::ValidationFailed, "Unsupported InfluxDB config value #{value.inspect}"
    end
  end

  def validate_settings!
    conflicts = new_resource.settings.keys.map(&:to_s) & RESERVED_SETTINGS
    return if conflicts.empty?

    raise Chef::Exceptions::ValidationFailed,
          "settings must not override explicit properties: #{conflicts.sort.join(', ')}"
  end
end
