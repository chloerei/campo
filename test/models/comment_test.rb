require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should count page" do
    topic = create(:topic)
    3.times { create :comment, commentable: topic }
    assert_equal 1, topic.comments.order(id: :asc).first.page(2)
    assert_equal 1, topic.comments.order(id: :asc).second.page(2)
    assert_equal 2, topic.comments.order(id: :asc).last.page(2)
  end
end
