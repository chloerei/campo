class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  enum value: { down: -1, up: 1 }

  validates :value, presence: true

  after_save :update_post_votes

  def update_post_votes
    if value_changed?
      post.increment! :votes, VALUE[value]
    end
  end
end
