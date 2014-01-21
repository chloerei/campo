class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :post_votes

  after_create :get_post_number, :create_notifications

  def get_post_number
    if post_number.blank?
      update_column :post_number, topic.posts.where('id < ?', id).count + 1
    end
  end

  def score
    votes_up - votes_down
  end

  def create_notifications
    create_post_topic_notification
  end

  def create_post_topic_notification
    Notification.create(user: topic.user,
                        subject: self,
                        name: 'post_topic')
  end
end
