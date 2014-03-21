require 'rouge/plugins/redcarpet'

module MarkdownHelper
  class HTMLRender < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  class TextReplaceVisitor
    def visit(node)
      if %w(a pre code).include?(node.name)
        return
      elsif node.text?
        node.replace(process(node.content))
      else
        node.children.each do |child|
          child.accept(self)
        end
      end
    end

    def process(text)
      # link mention
      # @username => <a href="/~username">@username</a>
      text.gsub!(/@([a-z0-9][a-z0-9-]*)/i) { |match|
        %Q|<a href="/~#{$1}">#{match}</a>|
      }

      # link comments
      # #123 => <a href="?comment_id=123#comment-123">#123</a>
      text.gsub!(/#(\d+)/) { |match|
        %Q|<a href="?comment_id=#{$1}#comment-#{$1}">#{match}</a>|
      }

      text
    end
  end

  def markdown_text_replace(html)
    doc = Nokogiri::HTML.fragment(html)
    doc.accept(TextReplaceVisitor.new)
    doc.to_html
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

  def markdown_format(text)
    sanitize(markdown_text_replace(markdown(text)),
             tags: %w(p br img h1 h2 h3 h4 blockquote pre code strong em a ul ol li span),
             attributes: %w(href src class title alt target rel))
  end

  def markdown_area(form, name, options = {})
    render partial: 'markdown/area', locals: options.merge(form: form, name: name)
  end
end
