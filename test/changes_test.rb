require 'test_helper'

class ChangesTest < ActiveSupport::TestCase

  test "record changes" do
    user = User.new
    assert user.cannot?(:destroy, Post)
    user.admin = true
    assert user.can?(:destroy, Post)
  end

end
