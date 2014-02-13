module CommentsHelper
  def comment_link(comment)
    case comment.commentable
    when Topic
      topic_path(comment.commentable, comment_id: comment.id, anchor: "comment-#{comment.id}")
    end
  end

  def comment_title(comment)
    case comment.commentable
    when Topic
      comment.commentable.title
    end
  end
end
