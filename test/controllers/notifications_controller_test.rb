require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
  test "should get index" do
    assert_require_logined do
      get :index
    end
    assert_response :success, @response.body
  end
end
