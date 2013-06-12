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

    ActiveModel::EachValidator.subclasses.each do |validator_class|
      name = validator_class.name.sub(/^.*::/, '').sub(/Validator$/, '').underscore

      define_method name do |options = {}, &block|
        if @klass.respond_to? "validates_#{name}_of"
          @klass.send "validates_#{name}_of", *(options.any? ? @attributes + [options] : @attributes)
        else
          @klass.validates_with validator_class, options.merge(attributes: @attributes)
        end
      end unless instance_methods(false).include? name.to_sym
    end
  end
end
