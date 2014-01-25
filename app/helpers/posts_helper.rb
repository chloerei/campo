module PostsHelper
  def format_post(text)
    sanitize(link_post_content(markdown(text)),
             tags: %w(p br img h1 h2 h3 h4 blockquote pre code strong em a ul ol li span),
             attributes: %w(href src class title alt target rel))
  end

  def link_post_content(text)
    doc = Nokogiri::HTML.fragment(text)

    doc.search('text()').each do |node|
      unless node.ancestors('a, pre, code').any?
        text = node.text
        # link @username
        text.gsub!(/@(\w+)/) { |match|
          username = $1
          %Q|<a href="/~#{username}">#{match}</a>|
        }

        # link #floor
        text.gsub!(/#(\d+)/) { |match|
          floor = $1
          page = (floor.to_i + 24) / 25
          %Q|<a href="?page=#{page}##{floor}">#{match}</a>|
        }
        node.replace text
      end
    end

    doc.to_html
  end
end
