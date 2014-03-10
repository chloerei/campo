class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, default: 'wavatar', rating: 'G', size: 48
  mount_uploader :avatar, AvatarUploader

  has_secure_password
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :attachments, dependent: :delete_all

  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A[a-z0-9-]+\z/i }
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[a-z0-9-]+\.)+[a-z]{2,})\z/i }

  scope :unlocked, -> { where(locked_at: nil) }
  scope :locked, -> { where.not(locked_at: nil) }

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && Rack::Utils.secure_compare(user.remember_token, token)) ? user : nil
  end

  def admin?
    CONFIG['admin_emails'] && CONFIG['admin_emails'].include?(email)
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

  def generate_password_reset_token
    update_attributes(password_reset_token: SecureRandom.hex(32),
                      password_reset_token_created_at: current_time_from_proper_timezone)
  end
end
