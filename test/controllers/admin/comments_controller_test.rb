require 'test_helper'

class Admin::CommentsControllerTest < ActionController::TestCase
  def setup
    login_as create(:admin)
  end

  test "should get index" do
    create :comment
    get :index
    assert_response :success, @response.body
  end

  test "should get show page" do
    comment = create(:comment)
    get :show, id: comment
    assert_response :success, @response.body
  end

  test "should update comment" do
    comment = create(:comment)
    patch :update, id: comment, comment: { body: 'change' }
    assert_equal 'change', comment.reload.body
  end

  test "should destroy comment" do
    comment = create(:comment)
    assert_difference "Comment.trashed.count" do
      delete :trash, id: comment
    end
    assert_redirected_to admin_comment_path(comment)
  end

  test "should restore comment" do
    comment = create(:comment)
    comment.trash
    assert_difference "Comment.trashed.count", -1 do
      patch :restore, id: comment
    end
    assert_redirected_to admin_comment_path(comment)
  end
end
