name 'sc-influxdb'
default_source :supermarket
run_list 'test::default'
cookbook 'sc-influxdb', path: '.'
cookbook 'test', path: 'test/fixtures/cookbooks/test'
