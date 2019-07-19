require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get main_top_url
    assert_response :success
  end

end
