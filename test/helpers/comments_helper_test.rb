require 'test_helper'

class CommentsHelperTest < ActionView::TestCase
  test "link mentions" do
    assert_equal %q|<p><a href="/~username">@username</a></p>|, link_mentions('<p>@username</p>')
    assert_equal %q|<a href="http://example.org/">@username</a>|, link_mentions(%q|<a href="http://example.org/">@username</a>|)
    assert_equal %q|<pre>@username</pre>|, link_mentions(%q|<pre>@username</pre>|)
    assert_equal %q|<code>@username</code>|, link_mentions(%q|<code>@username</code>|)
  end

  test "should link floor" do
    assert_equal %Q|<p><a href="?comment_id=1">#1</a></p>|, link_comments('<p>#1</p>')
    assert_equal %q|<a href="http://example.org/">#1</a>|, link_mentions(%q|<a href="http://example.org/">#1</a>|)
    assert_equal %q|<pre>#1</pre>|, link_mentions(%q|<pre>#1</pre>|)
    assert_equal %q|<code>#1</code>|, link_mentions(%q|<code>#1</code>|)
  end
end
