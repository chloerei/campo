module Admin::CommentsHelper
  def link_to_commentable(commentable)
    case commentable
    when Topic
      link_to truncate(commentable.title), admin_topic_path(commentable)
    end
  end
end
