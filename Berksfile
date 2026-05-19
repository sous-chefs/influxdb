# frozen_string_literal: true

source 'https://supermarket.chef.io'

metadata

cookbook 'gpg', path: '../gpg'
cookbook 'yum-epel', path: '../yum-epel'

group :integration do
  cookbook 'test', path: 'test/cookbooks/test'
end
