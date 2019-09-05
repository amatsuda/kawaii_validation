require 'test_helper'

class ValidationTest < ActiveSupport::TestCase
  setup do
    User.reset_callbacks(:validate)
    User._validators.clear
  end

  test 'no validation' do
    assert User.new.valid?
  end

  sub_test_case 'without attributes' do
    test 'without options' do
      User.validates do
        presence_of :name
      end

      user = User.new
      refute user.valid?
      assert_equal 1, user.errors.count
      assert_equal 1, user.errors[:name].count
    end

    test 'with an option' do
      User.validates do
        numericality_of :age, greater_than: 0
      end

      user = User.new age: -1
      refute user.valid?
      assert_equal 1, user.errors.count
      assert_equal 1, user.errors[:age].count
    end
  end

  sub_test_case 'with an attribute' do
    test 'without options' do
      User.validates :email do
        presence
      end

      user = User.new
      refute user.valid?
      assert_equal 1, user.errors.count
      assert_equal 1, user.errors[:email].count
    end

    test 'with an option' do
      User.validates :age do
        numericality greater_than: 0
      end

      user = User.new age: -1
      refute user.valid?
      assert_equal 1, user.errors.count
      assert_equal 1, user.errors[:age].count
    end
  end

  test 'mixtures' do
    User.class_eval do
      validates :email do
        size maximum: 100
        format with: /@/
      end
      validates :name, :age do
        presence
      end
    end

    user = User.new email: 'a' * 101
    refute user.valid?
    assert_equal 4, user.errors.count
    assert_equal 2, user.errors[:email].count
    assert_equal 1, user.errors[:name].count
    assert_equal 1, user.errors[:age].count
  end

  sub_test_case 'passing validate options to validates' do
    test 'if: can disable a test' do
      User.validates :name, if: :should_validate? do
        presence
      end

      user = User.new
      assert user.valid?
    end

    test 'unless: can enable a test' do
      User.validates :name, unless: :should_validate? do
        presence
      end

      user = User.new
      refute user.valid?
      assert_equal 1, user.errors.count
      assert_equal 1, user.errors[:name].count
    end
  end
end
