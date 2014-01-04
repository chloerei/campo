require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should get post_number after create" do
    assert_equal 1, create(:post).post_number
    assert_equal 2, create(:post, :topic => Topic.last).post_number
  end
end
