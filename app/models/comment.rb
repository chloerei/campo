class Comment < ActiveRecord::Base
  include Likeable
  include Trashable
  include MarkdownHelper

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true

  after_create :create_mention_notification, :create_comment_notification

  def page(per = Comment.default_per_page)
    @page ||= ((commentable.comments.where("id < ?", id).count) / per + 1)
  end

  def mention_users
    return @menton_users if defined?(@menton_users)

    doc = Nokogiri::HTML.fragment(markdown(body))
    usernames = doc.search('text()').map { |node|
      unless node.ancestors('a, pre, code').any?
        node.text.scan(/@(\w+)/).flatten
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
