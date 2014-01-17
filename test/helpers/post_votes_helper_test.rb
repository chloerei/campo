require 'test_helper'

class PostVotesHelperTest < ActionView::TestCase
  def setup
    @post = create(:post)
    @user = create(:user)
  end

  test "should check post_voted_up?" do
    assert !post_voted_up?(@post, @user)
    create(:post_vote, up: true, post: @post, user: @user)
    assert post_voted_up?(@post, @user)
  end

  test "should check post_voted_down?" do
    assert !post_voted_down?(@post, @user)
    create(:post_vote, up: false, post: @post, user: @user)
    assert post_voted_down?(@post, @user)
  end
end
