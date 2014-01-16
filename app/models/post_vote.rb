class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user, :post, presence: true

  after_create do
    if up?
      Post.update_counters post_id, votes_up: 1
    else
      Post.update_counters post_id, votes_down: 1
    end
    topic_calculate_hot
  end

  after_update do
    if up_changed?
      if up?
        Post.update_counters post_id, votes_up: 1, votes_down: -1
      else
        Post.update_counters post_id, votes_down: 1, votes_up: -1
      end
    end
    topic_calculate_hot
  end

  after_destroy do
    if up?
      Post.update_counters post_id, votes_up: -1
    else
      Post.update_counters post_id, votes_down: -1
    end
    topic_calculate_hot
  end

  def type
    up? ? 'up' : 'down'
  end

  def topic_calculate_hot
    post.topic.calculate_hot! if post.post_number == 1
  end
end
