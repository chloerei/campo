class MarkdownController < ApplicationController
  def preview
    render layout: false
  end
end
