require 'rouge/plugins/redcarpet'

module PostsHelper
  def post_votes(posts, user)
    user.post_votes.where(post_id: posts.pluck(:id)).map { |post_vote|
      { post_id: post_vote.post_id, type: post_vote.type }
    }
  end

  def format_post(content)
    sanitize(markdown_post(content),
             tags: %w(p br img h1 h2 h3 h4 blockquote pre code strong em a ul ol li span),
             attributes: %w(href src class title alt target rel))
  end

  class PostHTMLRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet

    def normal_text(text)
      # extract @username
      text.gsub!(/@(\w+)/) { |match|
        username = $1
        %Q|<a href="/~#{username}">#{match}</a>|
      }

      # extract #floor
      text.gsub!(/#(\d+)/) { |match|
        floor = $1
        page = (floor.to_i + 24) / 25
        %Q|<a href="?page=#{page}##{floor}">#{match}</a>|
      }

      text
    end
  end

  def markdown_post(content)
    renderer = PostHTMLRender.new(
      hard_wrap: true,
      filter_html: true,
      link_attributes: { rel: 'nofollow' }
    )

    markdown = Redcarpet::Markdown.new(renderer,
                                       autolink: true,
                                       space_after_headers: true,
                                       fenced_code_blocks: true)

    markdown.render(content)
  end
end
