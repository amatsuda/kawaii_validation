require 'spec_helper'

describe 'Model#validates with a block' do
  subject { User.new }
  before do
    User.reset_callbacks(:validate)
    User._validators.clear
  end

  context 'no validation' do
    it { should be_valid }
  end

  context 'without attributes' do
    context 'without options' do
      before do
        User.validates do
          presence_of :name
        end
      end

      it { should_not be_valid }
      it { should have(1).error_on(:name) }
    end

    context 'with an option' do
      before do
        User.validates do
          numericality_of :age, greater_than: 0
        end
      end

      subject { User.new age: -1 }
      it { should_not be_valid }
      it { should have(1).error_on(:age) }
    end
  end
end
