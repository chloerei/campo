require 'test_helper'

class MarkdownHelperTest < ActionView::TestCase
  test "should link mentions" do
    assert_equal %q|<p><a href="/~username">@username</a></p>|, markdown_text_replace('<p>@username</p>')
    assert_equal %q|<a href="http://example.org/">@username</a>|, markdown_text_replace(%q|<a href="http://example.org/">@username</a>|)
    assert_equal %q|<pre>@username</pre>|, markdown_text_replace(%q|<pre>@username</pre>|)
    assert_equal %q|<code>@username</code>|, markdown_text_replace(%q|<code>@username</code>|)
  end

  test "should link comments" do
    assert_equal %Q|<p><a href="?comment_id=1#comment-1">#1</a></p>|, markdown_text_replace('<p>#1</p>')
    assert_equal %q|<a href="http://example.org/">#1</a>|, markdown_text_replace(%q|<a href="http://example.org/">#1</a>|)
    assert_equal %q|<pre>#1</pre>|, markdown_text_replace(%q|<pre>#1</pre>|)
    assert_equal %q|<code>#1</code>|, markdown_text_replace(%q|<code>#1</code>|)
  end
end
