module CommentsHelper
  def comment_link(comment, options = {})
    options[:only_path] = true unless options[:only_path] == false
    case comment.commentable
    when Topic
      topic_path(comment.commentable, comment_id: comment.id, anchor: "comment-#{comment.id}", only_path: options[:only_path])
    end
  end

  def comment_title(comment)
    case comment.commentable
    when Topic
      comment.commentable.title
    else
      t 'helpers.comments.deleted_entry'
    end
  end

  def comment_replace_path(comment)
    case comment.commentable
    when Topic
      topic_last_path(@comment.commentable)
    end
  end
end
