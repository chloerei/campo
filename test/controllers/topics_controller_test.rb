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
        post :create, topic: { title: 'Title', posts_attributes: [ content: 'Content' ] }
      end
    end
    topic = Topic.last
    assert_equal 'Title', topic.title
    assert_equal 'Content', topic.posts.first.content
    assert_not_nil topic.user
    assert_equal topic.user, topic.posts.first.user
    assert_redirected_to topic
  end

  test "should edit topic" do
    topic = create(:topic)
    assert_require_logined do
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
    assert_require_logined do
      xhr :patch, :update, id: topic, topic: { title: 'change' }
    end
    assert_response :success, @response.body
    assert_equal 'change', topic.reload.title
  end
end
