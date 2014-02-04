require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  test "should like comment" do
    comment = create(:comment)
    login_as create(:user)

    assert_difference "comment.likes.count" do
      xhr :post, :create, comment_id: comment
    end
  end

  test "should unlike comment" do
    user = create(:user)
    comment = create(:comment)
    create :like, likeable: comment, user: user
    login_as user

    assert_difference "comment.likes.count", -1 do
      xhr :delete, :destroy, comment_id: comment.id
    end
  end
end
