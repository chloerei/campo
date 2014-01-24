require 'test_helper'

class PostVotesControllerTest < ActionController::TestCase
  def setup
    @post = create(:post)
  end

  test "should vote up post" do
    assert_difference "@post.post_votes.count" do
      assert_login_required do
        xhr :put, :update, id: @post, type: 'up'
      end
    end
    assert @post.post_votes.last.up?
  end

  test "should vote down post" do
    assert_difference "@post.post_votes.count" do
      assert_login_required do
        xhr :put, :update, id: @post, type: 'down'
      end
    end
    assert !@post.post_votes.last.up?
  end

  test "should not vote self post" do
    assert_no_difference "@post.post_votes.count" do
      assert_login_required(@post.user) do
        xhr :put, :update, id: @post, type: 'down'
      end
    end
  end

  test "should destroy vote" do
    user = create(:user)
    create(:post_vote, post: @post, user: user)

    assert_difference "@post.post_votes.count", -1 do
      assert_login_required(user) do
        xhr :delete, :destroy, id: @post
      end
    end
  end
end
