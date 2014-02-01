require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should create comment" do
    login_as create(:user)
    topic = create(:topic)

    assert_difference "topic.comments.count" do
      xhr :post, :create, comment: { commentable_type: 'Topic', commentable_id: topic, content: 'Content' }
    end
  end

  test "should edit comment" do
    comment = create(:comment)
    login_as comment.user

    xhr :get, :edit, id: comment
    assert_response :success, @response.body
  end
end
