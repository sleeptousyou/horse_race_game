require 'test_helper'

class PurcaseControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get purcase_show_url
    assert_response :success
  end

end
