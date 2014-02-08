module CommentsHelper
  def comment_permalink(comment)
    case comment.commentable
    when Topic
      topic_path(comment.commentable, comment_id: comment.id, anchor: "comment-#{comment.id}")
    end
  end
end
