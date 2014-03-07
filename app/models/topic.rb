class Topic < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  belongs_to :category
  has_many :comments, as: 'commentable'

  validates :title, :body, presence: true

  after_create :increment_counter_cache, :update_hot, :owner_subscribe
  after_destroy :decrement_counter_cache, unless: :trashed?
  after_touch :update_hot

  after_trash :decrement_counter_cache
  after_restore :increment_counter_cache

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
    # reload because comments_count has been cache in associations
    reload
    update_attribute :hot, calculate_hot
  end

  def owner_subscribe
    subscribe_by user
  end

  def total_pages
    (comments_count / Comment.default_per_page) + 1
  end

  def more_like_this
    Topic.search(
      query: {
        more_like_this: {
          fields: ['title', 'body'],
          like_text: title + '\n' + body
        }
      },
      filter: {
        and: [
          { term: { trashed: false } },
          { not: { term: { id: id } } }
        ]
      }
    )
  end
end
