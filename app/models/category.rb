class Category < ActiveRecord::Base
  has_many :topics, dependent: :nullify

  validates :name, presence: true
  validates :slug, presence: true, format: { with: /\A[a-zA-Z0-9-]+\z/ }, uniqueness: { case_sensitive: false }
end
