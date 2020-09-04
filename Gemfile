source ENV['GEM_SOURCE'] || "https://rubygems.org"

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'metadata-json-lint'
gem 'puppetlabs_spec_helper'
gem 'rake'
gem 'rspec-puppet'
gem 'rspec-puppet-facts'
gem 'rspec-puppet-utils'

# vim:ft=ruby
