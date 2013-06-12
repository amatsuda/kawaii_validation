require 'active_support/all'
require 'active_model/validations'

module KawaiiValidation
  # validates do
  #   presence_of :title, :if => -> { true }
  # end
  class NonAttributedValidator
    def initialize(klass)
      @klass = klass
    end

    ActiveModel::EachValidator.subclasses.each do |validator_class|
      name = validator_class.name.sub(/^.*::/, '').sub(/Validator$/, '').underscore

      define_method "#{name}_of" do |attrs, options = {}, &block|
        if @klass.respond_to? "validates_#{name}"
          @klass.send "validates_#{name}", *attrs, options
        else
          @klass.validates_with validator_class, options.merge(attributes: attrs)
        end
      end unless instance_methods(false).include? name.to_sym
    end
  end
end
