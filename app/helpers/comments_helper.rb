module CommentsHelper
  def format_comment(text)
    sanitize(link_comments(link_mentions(markdown(text))),
             tags: %w(p br img h1 h2 h3 h4 blockquote pre code strong em a ul ol li span),
             attributes: %w(href src class title alt target rel))
  end

  def link_mentions(text)
    doc = Nokogiri::HTML.fragment(text)

    doc.search('text()').each do |node|
      unless node.ancestors('a, pre, code').any?
        text = node.text

        # link @username
        text.gsub!(/@(\w+)/) { |match|
          %Q|<a href="/~#{$1}">#{match}</a>|
        }

        node.replace text
      end
    end

    doc.to_html
  end

  def link_comments(text)
    doc = Nokogiri::HTML.fragment(text)

    doc.search('text()').each do |node|
      unless node.ancestors('a, pre, code').any?
        text = node.text

        # link #comment_id
        text.gsub!(/#(\d+)/) { |match|
          %Q|<a href="?comment_id=#{$1}">#{match}</a>|
        }

        node.replace text
      end
    end

    doc.to_html
  end
end
