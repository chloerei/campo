require 'test_helper'

class PostsHelperTest < ActionView::TestCase
  test "post_votes" do
    user = create(:user)
    topic = create(:topic)
    create(:post, topic: topic)
    post_up = create(:post, topic: topic)
    post_down= create(:post, topic: topic)
    create(:post_vote, post: post_up, up: true, user: user)
    create(:post_vote, post: post_down, up: false, user: user)

    assert_equal(
      [{ post_id: post_up.id, type: 'up'}, { post_id: post_down.id, type: 'down' }].sort_by{ |v| v[:post_id] },
      post_votes(topic.posts, user).sort_by{ |v| v[:post_id] }
    )
  end

  test "should convert @username" do
    create :user, username: 'username'
    assert_equal %Q|<p><a href="/~username">@username</a></p>\n|, markdown_post('@username')
  end

  test "should convert floor" do
    assert_equal %Q|<p><a href="?page=1#1">#1</a></p>\n|, markdown_post('#1')

    assert_equal %Q|<p><a href="?page=1#25">#25</a></p>\n|, markdown_post("#25")
    assert_equal %Q|<p><a href="?page=2#26">#26</a></p>\n|, markdown_post("#26")
    assert_equal %Q|<p><a href="?page=3#51">#51</a></p>\n|, markdown_post("#51")
  end
end
