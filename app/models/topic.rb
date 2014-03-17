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
  after_update :update_category_counter
  after_destroy :decrement_counter_cache, unless: :trashed?
  after_touch :update_hot

  after_trash :decrement_counter_cache, :delete_all_likes
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

  def update_category_counter
    if category_id_changed?
      if category_id_was
        Category.update_counters category_id_was, topics_count: -1
      end

      if category_id
        Category.update_counters category_id, topics_count: 1
      end
    end
  end

  def delete_all_likes
    likes.delete_all
  end

  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_f / 45000
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
