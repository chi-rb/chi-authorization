require 'test_helper'

class ViewTest < ActionView::TestCase

  test 'can helper' do
    assert can?(:create, post)
  end

  test 'cannot helper' do
    assert cannot?(:read, post)
  end

  private

  def post
    @post ||= Post.new
  end

  def current_user
    @user ||= User.new
  end

end