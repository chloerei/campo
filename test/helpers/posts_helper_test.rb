require 'test_helper'

class PostsHelperTest < ActionView::TestCase
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
