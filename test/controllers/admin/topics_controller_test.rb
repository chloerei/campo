require 'test_helper'

class Admin::TopicsControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    topic = create(:topic)
    get :show, id: topic
    assert_response :success, @response.body
  end

  test "should destroy topic" do
    topic = create(:topic)
    assert_difference "Topic.count", -1 do
      delete :destroy, id: topic
    end
    assert_redirected_to admin_topics_path
  end
end
