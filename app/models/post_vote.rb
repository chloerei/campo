class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  enum value: { down: -1, up: 1 }

  validates :value, presence: true

  after_create do
    post.increment! :votes, VALUE[value]
  end

  after_update do
    if value_changed?
      # TODO value and value_was type is different, maybe change later.
      post.increment! :votes, (VALUE[value] - value_was)
    end
  end

  after_destroy do
    post.decrement! :votes, VALUE[value]
  end
end
