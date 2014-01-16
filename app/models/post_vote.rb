class PostVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user, :post, presence: true

  after_create do
    if up?
      Post.update_counters post_id, votes_up: 1
      Topic.update_counters post.topic_id, votes_up: 1
    else
      Post.update_counters post_id, votes_down: 1
      Topic.update_counters post.topic_id, votes_down: 1
    end
  end

  after_update do
    if up_changed?
      if up?
        Post.update_counters post_id, votes_up: 1, votes_down: -1
        Topic.update_counters post.topic_id, votes_up: 1, votes_down: -1
      else
        Post.update_counters post_id, votes_down: 1, votes_up: -1
        Topic.update_counters post.topic_id, votes_down: 1, votes_up: -1
      end
    end
  end

  after_destroy do
    if up?
      Post.update_counters post_id, votes_up: -1
      Topic.update_counters post.topic_id, votes_up: -1
    else
      Post.update_counters post_id, votes_down: -1
      Topic.update_counters post.topic_id, votes_down: -1
    end
  end

  def value
    up? ? 'up' : 'down'
  end
end
