# config
ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

module KawaiiValidationTestApp
  Application = Class.new(Rails::Application) do
    config.eager_load = false
    config.active_support.deprecation = :log
  end.initialize!
end

# models
class User < ActiveRecord::Base
  def should_validate?; false; end
end

# migrations
class CreateAllTables < ActiveRecord::VERSION::MAJOR >= 5 ? ActiveRecord::Migration[5.0] : ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :name; t.string :email; t.integer :age}
  end
end
