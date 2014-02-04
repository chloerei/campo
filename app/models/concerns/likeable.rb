module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: 'likeable', dependent: :delete_all
  end

  def liked_by?(user)
    likes.where(user: user).exists?
  end
end
