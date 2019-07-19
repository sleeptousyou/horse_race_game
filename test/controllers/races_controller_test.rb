require 'test_helper'

class RacesControllerTest < ActionDispatch::IntegrationTest
  test "should get bet" do
    get races_bet_url
    assert_response :success
  end

end
