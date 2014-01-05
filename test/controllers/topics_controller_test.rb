require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test "should get index page" do
    3.times { create(:topic) }
    get :index
    assert_response :success, @response.body
  end

  test "should get new page" do
    assert_require_logined do
      get :new
    end
    assert_response :success, @response.body
  end
end
