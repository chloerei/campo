require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new page" do
    get :new
    assert_response :success, @response.body
  end
end
