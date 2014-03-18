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
  end

  class MentionVisitor < TextReplaceVisitor
    def process(text)
      text.gsub(/@([a-z0-9][a-z0-9-]*)/) { |match|
        %Q|<a href="/~#{$1}">#{match}</a>|
      }
    end
  end

  class CommentVisitor < TextReplaceVisitor
    def process(text)
      text.gsub(/#(\d+)/) { |match|
        %Q|<a href="?comment_id=#{$1}#comment-#{$1}">#{match}</a>|
      }
    end
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
    sanitize(link_comments(link_mentions(markdown(text))),
             tags: %w(p br img h1 h2 h3 h4 blockquote pre code strong em a ul ol li span),
             attributes: %w(href src class title alt target rel))
  end

  def link_mentions(text)
    doc = Nokogiri::HTML.fragment(text)
    doc.accept(MentionVisitor.new)
    doc.to_html
  end

  def link_comments(text)
    doc = Nokogiri::HTML.fragment(text)
    doc.accept(CommentVisitor.new)
    doc.to_html
  end

  def markdown_area(form, name, options = {})
    render partial: 'markdown/area', locals: options.merge(form: form, name: name)
  end
end
