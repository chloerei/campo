require 'test_helper'

class PostVoteTest < ActiveSupport::TestCase
  test "should create post vote" do
    vote = create(:post_vote, value: 'up')
    assert_not_nil vote
    assert_equal 'up', vote.value
    assert vote.up?
  end

  test "should inc post votes" do
    post = create(:post)
    assert_equal 0, post.votes

    create(:post_vote, post: post, value: 'up')
    assert_equal 1, post.votes

    create(:post_vote, post: post, value: 'down')
    assert_equal 0, post.votes
  end

  test "should inc post votes after vote update" do
    post = create(:post)

    vote = create(:post_vote, post: post, value: 'up')
    assert_equal 1, post.votes

    vote.update_attribute :value, 'down'
    assert_equal(-1, post.votes)

    vote.update_attribute :value, 'up'
    assert_equal 1, post.votes

    vote.destroy
    assert_equal 0, post.votes
  end
end
