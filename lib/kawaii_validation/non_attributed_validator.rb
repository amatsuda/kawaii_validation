require 'active_support/all'
require 'active_model/validations'
require 'active_model/validations/with'

module KawaiiValidation
  # validates do
  #   presence_of :title, :if => -> { true }
  # end
  class NonAttributedValidator < BasicObject
    include ::ActiveModel::Validations::HelperMethods

    def initialize(klass)
      @klass = klass
    end

    def method_missing(name, *attributes)
      if @klass.respond_to? "validates_#{name}"
        @klass.send "validates_#{name}", *attributes
      else
        key = "#{name.to_s.sub(/_of\Z/, '').camelize}Validator"
        validator = begin
          key.include?('::') ? key.constantize : @klass.const_get(key)
        rescue NameError
          raise ArgumentError, "Unknown validator: '#{key}'"
        end

        @klass.validates_with validator, _merge_attributes(attributes)
      end
    end
  end
end
