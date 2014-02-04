class Subscription < ActiveRecord::Base
  enum status: [ :subscribed, :ignored ]

  belongs_to :user
  belongs_to :subscribable, polymorphic: true, counter_cache: true

  validates :user, :subscribable, presence: true
end
