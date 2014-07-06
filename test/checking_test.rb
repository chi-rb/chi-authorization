require 'test_helper'

class CheckingTest < ActiveSupport::TestCase

  test "can definition with model" do
    assert user.can?(:create, Post)
    assert !user.cannot?(:create, Post)
  end

  test "can definition with instance" do
    assert user.can?(:create, post)
    assert !user.cannot?(:create, post)
  end

  test "cannot definition" do
    assert user.cannot?('read', post)
    assert !user.can?('read', post)
  end

  test "ability conditions" do
    assert admin_user.can?(:destroy, post)
    assert user.cannot?(:destroy, post)
  end

  test "ability block" do
    assert user.can?(:edit, post_with_user)
  end

  test "manage action" do
    assert user.can?(:create, User)
    assert user.can?(:read, user)
    assert user.can?(:edit, user)
    assert user.can?(:destroy, user)
  end

  test "all subject" do
    assert user.can?(:touch, post)
    assert user.can?(:touch, user)
  end

  test "undefined definition" do
    assert user.cannot?(:other, post)
    assert user.cannot?(:other, post)
  end

  private

  def post_with_user
    @post_with_user ||= Post.new(user: user)
  end

  def post
    @post ||= Post.new
  end

  def user
    @user ||= User.new
  end

  def admin_user
    @admin_user ||= User.new(admin: true)
  end

end
