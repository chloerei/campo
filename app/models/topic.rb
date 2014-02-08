class Topic < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable

  belongs_to :user
  belongs_to :category, counter_cache: true
  has_many :comments, as: 'commentable'

  after_create :owner_subscribe

  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_i / 45000
  end

  def calculate_hot!
    update_attribute :hot, calculate_hot
  end

  def owner_subscribe
    subscribe_by user
  end
end
