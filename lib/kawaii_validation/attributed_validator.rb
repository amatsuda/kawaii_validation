require 'active_support/all'
require 'active_model/validations'
require 'active_model/validations/with'

module KawaiiValidation
  # validates(:title) do
  #   presence :if => -> { true }
  # end
  class AttributedValidator < (Rails::VERSION::MAJOR >= 4) ? ::ActiveSupport::ProxyObject : ::ActiveSupport::BasicObject
    include ::ActiveModel::Validations::HelperMethods

    def initialize(klass, *attributes)
      @klass, @attributes = klass, *attributes
    end

    def method_missing(name, *args)
      if @klass.respond_to? "validates_#{name}_of"
        @klass.send "validates_#{name}_of", *(args.any? ? @attributes + args : @attributes)
      else
        key = "#{name}Validator"
        validator = begin
          key.include?('::') ? key.constantize : @klass.const_get(key)
        rescue ::NameError
          rais ::ArgumentError, "Unknown validator: '#{key}'"
        end

        @klass.validates_with validator, _merge_attributes(@attributes)
      end
    end
  end
end
