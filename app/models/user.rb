class User < ActiveRecord::Base
  has_secure_password
  has_many :topics
  has_many :posts
  has_many :post_votes

  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A\w+\z/ }
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

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
end
