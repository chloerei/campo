class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_one :main_post, -> { where post_number: 1 }, class_name: 'Post'

  accepts_nested_attributes_for :main_post
end
