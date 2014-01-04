class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  accepts_nested_attributes_for :posts
end
