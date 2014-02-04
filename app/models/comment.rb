class Comment < ActiveRecord::Base
  include Likeable
  include Trashable
  include MarkdownHelper

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true

  after_create :create_mention_notification

  def page(per = Comment.default_per_page)
    @page ||= ((commentable.comments.where("id < ?", id).count) / per + 1)
  end

  def mention_users
    doc = Nokogiri::HTML.fragment(markdown(content))
    usernames = doc.search('text()').map { |node|
      unless node.ancestors('a, pre, code').any?
        node.text.scan(/@(\w+)/).flatten
      end
    }.flatten.compact.uniq

    usernames.any? ? User.where(username: usernames) : []
  end

  def create_mention_notification
    mention_users.each do |user|
      if user != self.user
        Notification.create(user: user,
                            subject: self,
                            name: 'comment_mention')
      end
    end
  end
end
