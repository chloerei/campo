class User < ActiveRecord::Base
  has_secure_password
  has_many :topics, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :notifications, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :like_topics, through: :likes, source: :likeable, source_type: 'Topic'

  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A[a-zA-Z0-9-]+\z/ }
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  scope :unlocked, -> { where(locked_at: nil) }
  scope :locked, -> { where.not(locked_at: nil) }

  def username=(value)
    write_attribute :username, value
    write_attribute :username_lower, value.downcase
  end

  def email=(value)
    write_attribute :email, value
    write_attribute :email_lower, value.downcase
  end

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && user.remember_token == token) ? user : nil
  end

  def admin?
    CONFIG['admin_emails'].include? email
  end

  def lock
    update_attribute :locked_at, current_time_from_proper_timezone
  end

  def unlock
    update_attribute :locked_at, nil
  end

  def locked?
    locked_at.present?
  end
end
