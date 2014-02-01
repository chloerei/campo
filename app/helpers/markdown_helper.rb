require 'rouge/plugins/redcarpet'

module MarkdownHelper
  class HTMLRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    renderer = HTMLRender.new(hard_wrap: true,
                              filter_html: true,
                              link_attributes: { rel: 'nofollow' })

    markdown = Redcarpet::Markdown.new(renderer,
                                       autolink: true,
                                       space_after_headers: true,
                                       fenced_code_blocks: true)

    markdown.render(text)
  end
end
