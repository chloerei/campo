class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validate :commentable_type, inclusion: { in: %w(Topic) }
  validate :commentable, :user, presence: true
end
