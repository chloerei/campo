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

  after_trash :delete_all_notifications

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
end
