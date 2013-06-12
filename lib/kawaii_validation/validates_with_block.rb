require 'active_support/all'
require 'active_record'
require 'kawaii_validation/non_attributed_validator'

module KawaiiValidation
  module ValidatesWithBlock
    def validates(*attributes, &block)
      if block
        if attributes.any?
          super
        else
          KawaiiValidation::NonAttributedValidator.new(self).instance_eval &block
        end
      else
        super
      end
    end
  end
end
