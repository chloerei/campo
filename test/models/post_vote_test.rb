require 'test_helper'

class PostVoteTest < ActiveSupport::TestCase
  test "should create post vote" do
    vote = create(:post_vote, value: 'up')
    assert_not_nil vote
    assert_equal 'up', vote.value
    assert vote.up?
  end
end
