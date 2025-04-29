# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in kawaii_validation.gemspec
gemspec

if ENV['RAILS_VERSION'] == 'edge'
  gem 'rails', git: 'https://github.com/rails/rails.git'
elsif ENV['RAILS_VERSION']
  gem 'rails', "~> #{ENV['RAILS_VERSION']}.0"
end

if ENV['RAILS_VERSION'] < '5.1'
  gem 'sqlite3', '< 1.4'
elsif (ENV['RAILS_VERSION'] <= '8') || (RUBY_VERSION < '3')
  gem 'sqlite3', '< 2'
end

gem 'selenium-webdriver'
