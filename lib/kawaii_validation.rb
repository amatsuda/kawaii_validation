require "kawaii_validation/version"
require 'kawaii_validation/validates_with_block'

class << ActiveRecord::Base
  prepend KawaiiValidation::ValidatesWithBlock
end
