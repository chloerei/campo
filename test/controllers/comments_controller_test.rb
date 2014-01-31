require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    login_as create(:user)
  end

  test "should create comment for topic" do
    topic = create(:topic)

    assert_difference "topic.comments.count" do
      xhr :post, :create, comment: { commentable_type: 'Topic', commentable_id: topic, content: 'Content' }
    end
  end
end
