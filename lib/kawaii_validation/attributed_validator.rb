require 'active_support/all'
require 'active_model/validations'

module KawaiiValidation
  class AttributedValidator
    # validates(:title) do
    #   presence :if => -> { true }
    # end
    def initialize(klass, *attributes)
      @klass, @attributes = klass, attributes
    end

    ActiveRecord::Base.public_methods(false).grep(/^validates_(.*)_of/) { $1 }.each do |name|
      define_method name do |options = {}, &block|
        @klass.send "validates_#{name}_of", *(options.any? ? @attributes + [options] : @attributes)
      end
    end unless instance_methods(false).include? name.to_sym

    ActiveModel::EachValidator.subclasses.each do |validator_class|
      name = validator_class.name.sub(/^.*::/, '').sub(/Validator$/, '').underscore

      define_method name do |options = {}, &block|
        @klass.validates_with validator_class, options.merge(attributes: @attributes)
      end unless instance_methods(false).include? name.to_sym
    end
  end
end
