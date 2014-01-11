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
    assert_require_logined do
      get :new
    end
    assert_response :success, @response.body
  end

  test "should create topic" do
    assert_difference "Topic.count" do
      assert_require_logined do
        post :create, topic: { title: 'Title', main_post_attributes: { content: 'Content' } }
      end
    end
    topic = Topic.last
    assert_equal 'Title', topic.title
    assert_not_nil topic.main_post
    assert_equal 'Content', topic.main_post.content
    assert_not_nil topic.user
    assert_equal topic.user, topic.main_post.user
    assert_redirected_to topic
  end

  test "should edit topic" do
    topic = create(:topic)
    assert_require_logined topic.user do
      xhr :get, :edit, id: topic
    end
    assert_response :success, @response.body
  end

  test "should get topic for cancel edit" do
    topic = create(:topic)
    xhr :get, :show, id: topic
    assert_response :success, @response.body
  end

  test "should update topic" do
    topic = create(:topic)
    assert_require_logined topic.user do
      xhr :patch, :update, id: topic, topic: { title: 'change', main_post_attributes: { content: 'change' } }
    end
    topic.reload
    assert_equal 'change', topic.title
    assert_equal 'change', topic.main_post.content
    assert_redirected_to topic
  end
end
