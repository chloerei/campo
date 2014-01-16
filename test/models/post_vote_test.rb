require 'test_helper'

class PostVoteTest < ActiveSupport::TestCase
  test "should create post vote" do
    vote = create(:post_vote, up: true)
    assert_not_nil vote
    assert_equal 'up', vote.value
    assert vote.up?
  end

  test "should inc post votes" do
    post = create(:post)
    assert_equal 0, post.votes

    create(:post_vote, post: post, up: true)
    post.reload
    assert_equal 1, post.votes_up
    assert_equal 0, post.votes_down

    create(:post_vote, post: post, up: false)
    post.reload
    assert_equal 1, post.votes_up
    assert_equal 1, post.votes_down
  end

  test "should inc post votes after vote update" do
    post = create(:post)

    vote = create(:post_vote, post: post, up: true)
    post.reload
    assert_equal 1, post.votes_up
    assert_equal 0, post.votes_down

    vote.update_attribute :up, false
    post.reload
    assert_equal 0, post.votes_up
    assert_equal 1, post.votes_down

    vote.update_attribute :up, true
    post.reload
    assert_equal 1, post.votes_up
    assert_equal 0, post.votes_down

    vote.destroy
    post.reload
    assert_equal 0, post.votes_up
    assert_equal 0, post.votes_down
  end
end
