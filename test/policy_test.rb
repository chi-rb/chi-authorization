require 'test_helper'

class PolicyTest < ActiveSupport::TestCase

  setup do
    @user = User.new
    @controller = ProductsController.new
    @controller.user = @user
    @product = Product.new
  end

  test 'authorize' do
    assert_nothing_raised do
      @controller.send :authorize!, :create, @product
    end
    assert_raises Abilities::AccessDenied do
      @controller.send :authorize!, :read, @product
    end
  end

  test 'any' do
    assert can?(:touch, :any)
    assert can?(:touch, @product)
    assert can?(:touch, @user)
  end

  test 'manage' do
    assert can?(:manage, @user)
    assert can?(:create, @user)
    assert can?(:edit, @user)
    assert can?(:destroy, @user)
    @user = User.new
    assert cannot?(:manage, @user)
    assert can?(:create, @user)
    assert cannot?(:edit, @user)
    assert cannot?(:destroy, @user)
  end

  test 'multiple' do
    assert can?(:create, @product)
    assert can?(:create, @user)
    assert can?(:view, @product)
    assert can?(:list, @product)
  end

  test 'cannot' do
    assert cannot?(:destroy, @product)
  end

  test 'undefined' do
    assert cannot?(:undefined, @product)
  end

  private

  %i(can? cannot?).each do |name|
    define_method name do |action, resource|
      @controller.send name, action, resource
    end
  end

end
