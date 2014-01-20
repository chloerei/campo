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

  test "should link mentions" do
    assert_equal %q|<p><a href="/~username">@username</a></p>|, link_post_content('<p>@username</p>')
    assert_equal %q|<a href="http://example.org/">@username</a>|, link_post_content(%q|<a href="http://example.org/">@username</a>|)
    assert_equal %q|<pre>@username</pre>|, link_post_content(%q|<pre>@username</pre>|)
    assert_equal %q|<code>@username</code>|, link_post_content(%q|<code>@username</code>|)
  end

  test "should link floor" do
    assert_equal %Q|<p><a href="?page=1#1">#1</a></p>|, link_post_content('<p>#1</p>')
    assert_equal %Q|<p><a href="?page=1#25">#25</a></p>|, link_post_content("<p>#25</p>")
    assert_equal %Q|<p><a href="?page=2#26">#26</a></p>|, link_post_content("<p>#26</p>")
    assert_equal %Q|<p><a href="?page=3#51">#51</a></p>|, link_post_content("<p>#51</p>")
  end
end
