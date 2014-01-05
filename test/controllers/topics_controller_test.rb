require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test "should get index" do
    3.times { create(:topic) }
    get :index
    assert_response :success, @response.body
  end
end
