class User < ActiveRecord::Base
  validates :username, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A\w+\z/ }
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
