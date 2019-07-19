require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get give" do
    get admin_give_url
    assert_response :success
  end

end
