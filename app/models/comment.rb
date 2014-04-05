class Comment < ActiveRecord::Base
  include Likeable
  include Trashable
  include MarkdownHelper

  has_many :notifications, as: 'subject', dependent: :delete_all
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true, touch: true

  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true
  validates :body, presence: true

  after_create :create_mention_notification, :create_comment_notification

  after_trash :decrement_counter_cache, :delete_all_notifications
  after_restore :increment_counter_cache
  after_destroy :increment_counter_cache, if: :trashed?

  def increment_counter_cache
    if commentable.has_attribute? :comments_count
      commentable.class.update_counters commentable.id, comments_count: 1
    end
  end

  def decrement_counter_cache
    if commentable.has_attribute? :comments_count
      commentable.class.update_counters commentable.id, comments_count: -1
    end
  end

  def delete_all_notifications
    notifications.delete_all
  end

  def page(per = Comment.default_per_page)
    @page ||= ((commentable.comments.where("id < ?", id).count) / per + 1)
  end

  def mention_users
    return @menton_users if defined?(@menton_users)

    doc = Nokogiri::HTML.fragment(markdown(body))
    usernames = doc.search('text()').map { |node|
      unless node.ancestors('a, pre, code').any?
        node.text.scan(/@([a-z0-9][a-z0-9-]*)/i).flatten
      end
    }.flatten.compact.uniq

    @menton_users = User.where(username: usernames)
  end

  def create_mention_notification
    users = mention_users - [user]
    if commentable.respond_to? :ignored_users
      users = users - commentable.ignored_users
    end

    users.each do |user|
      Notification.create(user: user,
                          subject: self,
                          name: 'mention')
    end
  end

  def create_comment_notification
    if commentable.respond_to? :subscribed_users
      users = commentable.subscribed_users - mention_users - [user]

      users.each do |user|
        Notification.create(user: user,
                            subject: self,
                            name: 'comment')
      end
    end
  end
end
