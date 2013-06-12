require "kawaii_validation/version"
require 'kawaii_validation/validates_with_block'

ActiveModel::Validations::ClassMethods.send :prepend, KawaiiValidation::ValidatesWithBlock
