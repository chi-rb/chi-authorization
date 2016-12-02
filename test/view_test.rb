require 'test_helper'

class ViewTest < ActionDispatch::IntegrationTest

  test 'helpers' do
    get product_path
    assert_response :success
    assert_select 'a', 'Touch'
    assert_select 'a', 'Destroy'
  end

end
