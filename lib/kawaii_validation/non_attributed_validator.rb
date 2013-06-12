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

    ActiveRecord::Base.public_methods(false).grep(/^validates_(.*)_of$/) { $1 }.each do |name|
      define_method "#{name}_of" do |attrs, options = {}, &block|
        @klass.send "validates_#{name}_of", *attrs, options
      end unless instance_methods(false).include? "#{name}_of".to_sym
    end

    ActiveModel::EachValidator.subclasses.each do |validator_class|
      name = validator_class.name.sub(/^.*::/, '').sub(/Validator$/, '').underscore

      define_method "#{name}_of" do |attrs, options = {}, &block|
        @klass.validates_with validator_class, options.merge(attributes: attrs)
      end unless instance_methods(false).include? name.to_sym
    end
  end
end
