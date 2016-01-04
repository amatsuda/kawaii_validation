$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
# load Rails first
require 'rails'

# load the plugin
require 'kawaii_validation'

# needs to load the app next
require 'fake_app'

require 'test/unit/rails/test_help'
# require 'action_controller/railtie' # needed for Rails 4 + RSpec...

module DatabaseDeleter
  def setup
    User.delete_all
    super
  end
end

Test::Unit::TestCase.send :prepend, DatabaseDeleter

CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'users'
