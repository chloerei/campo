class Post < ActiveRecord::Base
  include MarkdownHelper

  belongs_to :topic, counter_cache: true
  belongs_to :user
  has_and_belongs_to_many :like_users, class_name: 'User', join_table: 'post_likes'

  after_create :get_post_number, :create_notifications, :calculate_topic_hot

  def get_post_number
    if post_number.blank?
      update_column :post_number, topic.posts.where('id < ?', id).count + 1
    end
  end

  def create_notifications
    create_post_topic_notification
    create_mention_notification
  end

  def create_post_topic_notification
    if user != topic.user
      Notification.create(user: topic.user,
                          subject: self,
                          name: 'post_topic')
    end
  end

  def mentions
    doc = Nokogiri::HTML.fragment(markdown(content))
    usernames = doc.search('text()').map { |node|
      unless node.ancestors('a, pre, code').any?
        node.text.scan(/@(\w+)/).flatten
      end
    }.flatten.compact.uniq

    usernames.any? ? User.where(username: usernames) : []
  end

  def create_mention_notification
    mentions.each do |user|
      if user != self.user
        Notification.create(user: user,
                            subject: self,
                            name: 'post_mention')
      end
    end
  end

  def calculate_topic_hot
    topic.calculate_hot!
  end
end
