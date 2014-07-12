class Topic < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  belongs_to :category, counter_cache: true
  has_many :comments, as: 'commentable'

  validates :title, :body, presence: true

  after_create :update_hot, :owner_subscribe
  after_touch :update_hot

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
    (comments_count.to_f / Comment.default_per_page).ceil
  end

  def more_like_this(num = 5)
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
    ).limit(num).records.to_a rescue []
  end
end
