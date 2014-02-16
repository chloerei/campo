class Topic < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable

  belongs_to :user
  belongs_to :category
  has_many :comments, as: 'commentable'

  validates :title, :body, presence: true

  after_create :increment_counter_cache, :update_hot, :owner_subscribe
  after_destroy :decrement_counter_cache, unless: :trashed?

  set_callback :trash, :after, :decrement_counter_cache
  set_callback :restore, :after, :increment_counter_cache

  def increment_counter_cache
    if category
      Category.update_counters category.id, topics_count: 1
    end
  end

  def decrement_counter_cache
    if category
      Category.update_counters category.id, topics_count: -1
    end
  end

  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_i / 45000
  end

  def update_hot
    update_attribute :hot, calculate_hot
  end

  def owner_subscribe
    subscribe_by user
  end

  def after_comments_count_change
    reload.update_hot
  end
end
