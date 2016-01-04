require 'active_support/all'
require 'active_record'
require 'kawaii_validation/attributed_validator'
require 'kawaii_validation/non_attributed_validator'

module KawaiiValidation
  module ValidatesWithBlock
    def validates(*attributes, &block)
      if block
        validates_block_validator = if attributes.any?
          KawaiiValidation::AttributedValidator.new self, attributes
        else
          KawaiiValidation::NonAttributedValidator.new self
        end
        validates_block_validator.instance_eval(&block)
      else
        super
      end
    end
  end
end
