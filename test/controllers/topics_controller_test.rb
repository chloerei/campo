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

  test "should redirect to comment page" do
    topic = create(:topic)
    (Comment.default_per_page + 1).times { create :comment, commentable: topic, user: topic.user }
    comment = topic.comments.order(id: :asc).last
    get :show, id: topic, comment_id: comment
    assert_equal comment.page, assigns(:comments).current_page
  end

  test "should get new page" do
    login_as create(:user)
    get :new
    assert_response :success, @response.body
  end

  test "should create topic" do
    login_as create(:user)
    assert_difference "Topic.count" do
      xhr :post, :create, topic: attributes_for(:topic)
    end
    topic = Topic.last
    assert_equal topic.user, topic.user
  end

  test "should edit topic" do
    topic = create(:topic)
    login_as topic.user
    get :edit, id: topic
    assert_response :success, @response.body
  end

  test "should update topic" do
    topic = create(:topic)
    login_as topic.user
    xhr :patch, :update, id: topic, topic: { title: 'change', body: 'change' }
    topic.reload
    assert_equal 'change', topic.title
    assert_equal 'change', topic.body
  end

  test "should not create topic for locked user" do
    user = create(:user)
    user.lock
    login_as user
    assert_no_difference "Topic.count" do
      assert_raise(ApplicationController::AccessDenied) do
        post :create, topic: attributes_for(:topic)
      end
    end
  end

  test "should trash topic" do
    topic = create(:topic)
    login_as topic.user

    assert_difference "Topic.trashed.count" do
      delete :trash, id: topic
    end
  end
end
