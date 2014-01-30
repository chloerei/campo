require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test "should get index page" do
    3.times { create(:topic) }
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    get :show, id: create(:topic)
    assert_response :success, @response.body
  end

  test "should get new page" do
    assert_login_required do
      get :new
    end
    assert_response :success, @response.body
  end

  test "should create topic" do
    assert_difference "Topic.count" do
      assert_login_required do
        post :create, topic: attributes_for(:topic)
      end
    end
    topic = Topic.last
    assert_equal topic.user, topic.user
    assert_redirected_to topic
  end

  test "should edit topic" do
    topic = create(:topic)
    assert_login_required topic.user do
      get :edit, id: topic
    end
    assert_response :success, @response.body
  end

  test "should update topic" do
    topic = create(:topic)
    assert_login_required topic.user do
      patch :update, id: topic, topic: { title: 'change', body: 'change' }
    end
    topic.reload
    assert_equal 'change', topic.title
    assert_equal 'change', topic.body
    assert_redirected_to topic
  end
end
