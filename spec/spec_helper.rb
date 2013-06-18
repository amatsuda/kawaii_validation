$LOAD_PATH.unshift(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift(__dir__)

require 'rails'
require 'kawaii_validation'
require 'fake_app'
require 'action_controller/railtie' # needed for Rails 4 + RSpec...
require 'rspec/rails'

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'users'
  end
  config.before :each do
    User.delete_all
  end
end
