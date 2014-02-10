require 'test_helper'

class Admin::TopicsControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    create :topic
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    topic = create(:topic)
    get :show, id: topic
    assert_response :success, @response.body
  end

  test "should update topic" do
    topic = create(:topic)
    patch :update, id: topic, topic: { title: 'change' }
    assert_equal 'change', topic.reload.title
  end

  test "should destroy topic" do
    topic = create(:topic)
    assert_difference "Topic.trashed.count" do
      delete :trash, id: topic
    end
    assert_redirected_to admin_topic_path(topic)
  end

  test "should restore topic" do
    topic = create(:topic)
    topic.trash
    assert_difference "Topic.trashed.count", -1 do
      patch :restore, id: topic
    end
    assert_redirected_to admin_topic_path(topic)
  end
end
