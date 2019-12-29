source 'https://rubygems.org'

gemspec :path => '../'

gem 'railties', '~> 4.2.0'
gem 'activerecord', '~> 4.2.0'
gem 'sqlite3', '< 1.4'
gem 'nokogiri', RUBY_VERSION < '2.1' ? '~> 1.6.0' : '>= 1.7'
