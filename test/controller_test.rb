require 'test_helper'

class ControllerTest < ActiveSupport::TestCase

  test "can helper" do
    assert controller.send(:can?, :create, post)
  end

  test "cannot helper" do
    assert controller.send(:cannot?, :read, post)
  end

  test "authorize helper" do
    assert_nothing_raised do
      controller.send :authorize!, :create, post
    end
    assert_raises Abilities::AccessDenied do
      controller.send :authorize!, :read, post
    end
  end

  private

  def controller
    @controller ||= ActionController::Base.new.tap do |controller|
      controller.class_eval do
        define_method :current_user do
          @user ||= User.new
        end
      end
    end
  end

  def post
    @post ||= Post.new
  end

end
