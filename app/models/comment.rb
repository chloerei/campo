class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validate :commentable_type, inclusion: { in: %w(Topic) }
  validate :commentable, :user, presence: true

  def page(per = Comment.default_per_page)
    @page ||= ((commentable.comments.where("id < ?", id).count) / per + 1)
  end
end
